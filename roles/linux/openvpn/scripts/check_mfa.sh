#!/bin/bash

# ##############################################################################

function check_mfa() {
  user_id=$1

  MFA_LABEL="${user_id}@openvpn"
  MFA_ISSUER="CHANGE-ME" 
  MFA_DIR=/etc/openvpn/google-authenticator

  if [ "$user_id" == "" ]; then
    echo "ERROR: No user id provided to generate MFA token"
    exit 1
  fi

  pamtester openvpn ${user_id}  authenticate

}

function main() {
  user_id=$1

  if [ "$user_id" == "" ]; then
    echo "ERROR: No user id provided"
    exit 1
  fi

  check_mfa $user_id

  exit 0
}

# ##############################################################################

main $1
