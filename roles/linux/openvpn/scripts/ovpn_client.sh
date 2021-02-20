#!/bin/bash

# OpenVPN configuration Directory
OPENVPN_CFG_DIR=/etc/openvpn

# Directory where EasyRSA outputs the client keys and certificates
KEY_DIR=/etc/openvpn/easy-rsa/keys

# Where this script should create the OpenVPN client config files
OUTPUT_DIR=/etc/openvpn/client

# Base configuration for the client
BASE_CONFIG=/etc/openvpn/client

# ##############################################################################

function send_mail() {
  attachment=$1

  which mutt 2>&1 >/dev/null

  if [ $? -ne 0 ]; then
    echo "INFO: mail program not found, an email will not be sent to the user"
  else
    echo -en "Please, provide the e-mail of the user\n> "
    read email
    echo "INFO: Sending email"
    echo "Here is your OpenVPN client configuration" | mutt -s "Your OpenVPN configuration" -a "$attachment" -- "$email"
  fi
}

function main() {
  user_id=$1

  if [ "$user_id" == "" ]; then
    echo "ERROR: No user id provided"
    exit 1
  fi

  if [ ! -f ${KEY_DIR}/ca.crt ]; then
    echo "ERROR: CA certificate not found"
    exit 1
  fi

  if [ ! -f ${KEY_DIR}/${user_id}.crt ]; then
    echo "ERROR: User certificate not found"
    exit 1
  fi

  if [ ! -f ${KEY_DIR}/${user_id}.key ]; then
    echo "ERROR: User private key not found"
    exit 1
  fi

  if [ ! -f ${KEY_DIR}/ta.key ]; then
    echo "ERROR: TLS Auth key not found"
    exit 1
  fi

  cat ${BASE_CONFIG}/${user_id}-client.conf \
      <(echo -e '<ca>') \
      ${KEY_DIR}/ca.crt \
      <(echo -e '</ca>\n<cert>') \
      ${KEY_DIR}/${user_id}.crt \
      <(echo -e '</cert>\n<key>') \
      ${KEY_DIR}/${user_id}.key \
      <(echo -e '</key>\n<tls-auth>') \
      ${KEY_DIR}/ta.key \
      <(echo -e '</tls-auth>') \
      > ${OUTPUT_DIR}/${user_id}.ovpn

  echo "INFO: Key created in ${OUTPUT_DIR}/${user_id}.ovpn"

  #send_mail "${OUTPUT_DIR}/${user_id}.ovpn"

  exit 0
}

# ##############################################################################

main $1
