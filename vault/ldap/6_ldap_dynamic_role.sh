#!/bin/bash

. env.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cat << EOF
vault write openldap/role/dynamic-role
    creation_ldif=@${DIR}/dynamic_role_ldif/creation.ldif
    deletion_ldif=@${DIR}/dynamic_role_ldif/deletion.ldif
    rollback_ldif=@${DIR}/dynamic_role_ldif/rollback.ldif
    default_ttl=5m
    max_ttl=1h
EOF
p

vault write openldap/role/dynamic-role \
    creation_ldif=@${DIR}/dynamic_role_ldif/creation.ldif \
    deletion_ldif=@${DIR}/dynamic_role_ldif/deletion.ldif \
    rollback_ldif=@${DIR}/dynamic_role_ldif/rollback.ldif \
    default_ttl=5m \
    max_ttl=1h

pe "vault read openldap/creds/dynamic-role"

pe "vault read openldap/creds/dynamic-role"
