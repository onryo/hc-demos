#!/bin/bash

. env.sh

pe "vault secrets enable openldap"

# Using group of unique names lookups
cat << EOF
vault write openldap/config
    binddn="${BIND_DN}"
    bindpass="${BIND_PW}"
    url="${LDAP_URL}"
EOF
p

vault write openldap/config \
    binddn="${BIND_DN}" \
    bindpass="${BIND_PW}" \
    url="${LDAP_URL}" \
    insecure_tls=true

echo
green "Rotation helps to minimize exposure of the configured credential and ensures" 
green "  that Vault has exclusive control of the rotated root credentials."
pe "vault write -f openldap/rotate-root"

