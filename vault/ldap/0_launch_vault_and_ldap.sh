#!/bin/bash

. env.sh

# Get the relative directory name
# Sorry windows folks, you're gonna have to figure this out and modify it for you pleasure
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# start Vault
cat << EOF
docker run --name vault-demo \
  -p 8200:8200 \
  --detach --rm vault server -dev -dev-root-token-id=root
EOF
p

docker run --name vault-demo \
  -p 8200:8200 \
  --detach --rm vault server -dev -dev-root-token-id=root


# start OpenLDAP
cat << EOF
docker run --name vault-openldap-demo
  -p 389:389
  -p 689:689
  -e LDAP_ORGANISATION="${LDAP_ORGANISATION}"
  -e LDAP_DOMAIN="${LDAP_DOMAIN}"
  -e LDAP_ADMIN_PASSWORD="${LDAP_ADMIN_PASSWORD}"
  -e LDAP_READONLY_USER=${LDAP_READONLY_USER}
  -e LDAP_READONLY_USER_USERNAME=${LDAP_READONLY_USER_USERNAME}
  -e LDAP_READONLY_USER_PASSWORD=${LDAP_READONLY_USER_PASSWORD}
  -v ${DIR}/ldif:/container/service/slapd/assets/config/bootstrap/ldif/custom
  --detach --rm osixia/openldap:${OPENLDAP_DOCKER_VERSION} --copy-service
EOF
p

docker run --name vault-openldap-demo \
  -p 389:389 \
  -p 689:689 \
  -e LDAP_ORGANISATION="${LDAP_ORGANISATION}" \
  -e LDAP_DOMAIN="${LDAP_DOMAIN}" \
  -e LDAP_ADMIN_PASSWORD="${LDAP_ADMIN_PASSWORD}" \
  -e LDAP_READONLY_USER=${LDAP_READONLY_USER} \
  -e LDAP_READONLY_USER_USERNAME=${LDAP_READONLY_USER_USERNAME} \
  -e LDAP_READONLY_USER_PASSWORD=${LDAP_READONLY_USER_PASSWORD} \
  -v ${DIR}/ldif:/container/service/slapd/assets/config/bootstrap/ldif/custom \
  --detach --rm osixia/openldap:${OPENLDAP_DOCKER_VERSION} --copy-service
