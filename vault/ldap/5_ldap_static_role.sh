#!/bin/bash

. env.sh

cat << EOF
vault write openldap/static-role/demo
    dn="$DEMO_USER_DN"
    username="$DEMO_USER_NAME"
    rotation_period="15s"
EOF
p

vault write openldap/static-role/demo \
    dn="$DEMO_USER_DN" \
    username="$DEMO_USER_NAME" \
    rotation_period="15s"

unset VAULT_TOKEN
pe "vault login -method=ldap username=george password=${USER_PASSWORD}"
pe "vault read openldap/static-cred/demo"
pe "vault read openldap/static-cred/demo"
pe "vault write -f openldap/rotate-role/demo"
pe "vault read openldap/static-cred/demo"

unset VAULT_TOKEN
pe "vault login -method=ldap username=bgreen password=${USER_PASSWORD}"
pe "vault read openldap/static-cred/demo"
