#!/bin/bash

# Demo Magic tooling
# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.

export PATH=${PATH}:../../demo-tools

# This is for the time to wait when using demo_magic.sh
if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

. demo-magic.sh -d -p -w ${DEMO_WAIT}

export VAULT_ADDR=https://vault.service.consul:8200
unset VAULT_TOKEN

SIGNED_CERT_FILE=/tmp/vault-demo-signed-cert.pub

rm $SIGNED_CERT_FILE 2> /dev/null

pe "vault login -method=ldap"

pe "vault policy read admin"

pe "vault read /ssh/config/ca"

pe "vault read /ssh/roles/admin"

pe "vault write -field=signed_key /ssh/sign/admin valid_principals=root public_key=@${HOME}/.ssh/id_rsa.pub > $SIGNED_CERT_FILE"

pe "ssh-keygen -Lf $SIGNED_CERT_FILE"

pe "ssh -i $SIGNED_CERT_FILE -i ${HOME}/.ssh/id_rsa root@test-vault-01 \"uname -a\""

pe "vault ssh -mode=ca -role=admin root@test-vault-01"