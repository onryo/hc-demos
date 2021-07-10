#!/bin/bash

. env.sh

# Get the relative directory name
# Sorry windows folks, you're gonna have to figure this out and modify it for you pleasure
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cat << EOF
docker run --name vault-openldap-demo
  -p 389:389
  -p 689:689
  -e LDAP_ORGANISATION="${LDAP_ORGANISATION}"
  -e LDAP_DOMAIN="${LDAP_DOMAIN}"
  -e LDAP_ADMIN_PASSWORD="${BIND_PW}"
  -v ${DIR}/ldif:/container/service/slapd/assets/config/bootstrap/ldif/custom
  --detach --rm osixia/openldap:latest
EOF
p

docker run --name vault-openldap-demo \
  -p 389:389 \
  -p 689:689 \
  -e LDAP_ORGANISATION="${LDAP_ORGANISATION}" \
  -e LDAP_DOMAIN="${LDAP_DOMAIN}" \
  -e LDAP_ADMIN_PASSWORD="${BIND_PW}" \
  -v ${DIR}/ldif:/container/service/slapd/assets/config/bootstrap/ldif/custom \
  --detach --rm osixia/openldap:1.2.2 --copy-service
