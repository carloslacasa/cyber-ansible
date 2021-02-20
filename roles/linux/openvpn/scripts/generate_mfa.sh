#!/bin/bash

# ##############################################################################

function generate_mfa() {
  user_id=$1

  MFA_LABEL="${user_id}@openvpn"
  MFA_ISSUER="CHANGE-ME"
  MFA_DIR=/etc/openvpn/google-authenticator

  if [ "$user_id" == "" ]; then
    echo "ERROR: No user id provided to generate MFA token"
    exit 1
  fi

  echo "INFO: Generating MFA Token"
  su -c "google-authenticator -t -d -r3 -R30 -f -i \"${MFA_ISSUER}\"  -l \"${MFA_LABEL}\" -s ${MFA_DIR}/${user_id}" - root
  chown gauth ${MFA_DIR}/${user_id}
  chmod 400 ${MFA_DIR}/${user_id}
}

function main() {
  user_id=$1

  if [ "$user_id" == "" ]; then
    echo "ERROR: No user id provided"
    exit 1
  fi

  generate_mfa $user_id

  exit 0
}

# ##############################################################################

main $1
