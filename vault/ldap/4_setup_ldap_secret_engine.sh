#!/bin/bash

. env.sh

pe "vault secrets enable openldap"

# Using group of unique names lookups
cat << EOF
vault write openldap/config
    binddn="${LDAP_ADMIN_DN}"
    bindpass="${LDAP_ADMIN_PASSWORD}"
    url="${LDAP_URL}"
EOF
p

vault write openldap/config \
    binddn="${LDAP_ADMIN_DN}" \
    bindpass="${LDAP_ADMIN_PASSWORD}" \
    url="${LDAP_URL}" \
    insecure_tls=true

echo
green "Rotation helps to minimize exposure of the configured credential and ensures" 
green "  that Vault has exclusive control of the rotated root credentials."
pe "vault write -f openldap/rotate-root"

pe "vault policy write openldap_read_and_rotate policies/openldap_read_and_rotate_policy.hcl"
pe "vault policy read openldap_read_and_rotate"
pe "vault policy write openldap_read_dynamic_role policies/openldap_read_dynamic_role_policy.hcl"
pe "vault policy read openldap_read_dynamic_role"

pe "vault write auth/ldap/groups/solutions_engineering policies=openldap_read_and_rotate,se_kv_full,pro_svcs_kv_read"
pe "vault write auth/ldap/groups/pro_svcs policies=openldap_read_dynamic_role,pro_svcs_kv_full,se_kv_read"

