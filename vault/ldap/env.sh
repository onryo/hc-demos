#!/bin/bash

# Environment variables for this local demo
OPENLDAP_DOCKER_VERSION=1.2.2
LDAP_HOST=${LDAP_HOST:-vault-openldap-demo}
LDAP_URL="ldap://${LDAP_HOST}"
LDAP_ORGANISATION=${LDAP_ORGANISATION:-"HashiCorp Inc"}
LDAP_DOMAIN=${LDAP_DOMAIN:-"hashidemos.com"}
LDAP_HOSTNAME=${LDAP_HOSTNAME:-"ldap.hashidemos.com"}
LDAP_READONLY_USER=${LDAP_READONLY_USER:-true}
LDAP_READONLY_USER_USERNAME=${LDAP_READONLY_USER_USERNAME:-read-only}
LDAP_READONLY_USER_PASSWORD=${LDAP_READONLY_USER_PASSWORD:-"devsecopsFTW"}
LDAP_ADMIN_DN=${LDAP_ADMIN_DN:-"cn=admin,dc=hashidemos,dc=com"}
LDAP_ADMIN_PASSWORD=${LDAP_ADMIN_PASSWORD:-"hashifolk"}
BIND_DN=${BIND_DN:-"cn=read-only,dc=hashidemos,dc=com"}
BIND_PW=${BIND_PW:-"devsecopsFTW"}
GROUP_DN=${GROUP_DN:-"ou=groups,dc=hashidemos,dc=com"}
GROUP_FILTER=${GROUP_FILTER:-"(&(objectClass=groupOfUniqueNames)(uniqueMember={{.UserDN}}))"}
GROUP_ATTR=${GROUP_ATTR:-"cn"}
USER_DN=${USER_DN:-"ou=people,dc=hashidemos,dc=com"}
USER_ATTR=${USER_ATTR:-"cn"}
USER_PASSWORD=${USER_PASSWORD:-"notagoodpassword"}
DEMO_USER_DN=${DEMO_USER_DN:-"cn=static_role_demo_user,ou=service_acct,dc=hashidemos,dc=com"}
DEMO_USER_NAME=${DEMO_USER_NAME:-"static_role_demo_user"}

# Demo Magic tooling
# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.

export PATH=${PATH}:../../demo-tools

# This is for the time to wait when using demo_magic.sh
if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

. demo-magic.sh -d -p -w ${DEMO_WAIT}
