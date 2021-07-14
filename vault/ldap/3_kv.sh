#!/bin/bash

. env.sh

pe "vault policy write se_kv_full policies/se_kv_full_policy.hcl"
pe "vault policy read se_kv_full"
pe "vault policy write se_kv_read policies/se_kv_read_policy.hcl"
pe "vault policy read se_kv_read"

pe "vault policy write pro_svcs_kv_full policies/pro_svcs_kv_full_policy.hcl"
pe "vault policy read pro_svcs_kv_full"
pe "vault policy write pro_svcs_kv_read policies/pro_svcs_kv_read_policy.hcl"
pe "vault policy read pro_svcs_kv_read"

pe "vault write auth/ldap/groups/solutions_engineering policies=se_kv_full,pro_svcs_kv_read"
pe "vault write auth/ldap/groups/pro_svcs policies=pro_svcs_kv_full,se_kv_read"


# Test Unique Member logins and capabilities
unset VAULT_TOKEN
pe "vault login -method=ldap username=george password=${USER_PASSWORD}"
pe "vault kv put secret/solutions_engineering/db password=engineersgonnasolution"
pe "vault kv put secret/pro_svcs/db password=engineersgonnasolution"

unset VAULT_TOKEN
pe "vault login -method=ldap username=bgreen password=${USER_PASSWORD}"
pe "vault kv put secret/pro_svcs/db password=prosvcsgonnabuild"
pe "vault kv put secret/solutions_engineering/db password=prosvcsgonnabuild"
pe "vault kv get secret/solutions_engineering/db"
