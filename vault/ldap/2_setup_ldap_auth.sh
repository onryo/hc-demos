#!/bin/bash

. env.sh

pe "vault auth enable -path=ldap ldap"

# Using group of unique names lookups
cat << EOF
vault write auth/ldap/config
    url="${LDAP_URL}"
    binddn="${BIND_DN}"
    bindpass="${BIND_PW}"
    userdn="${USER_DN}"
    userattr="${USER_ATTR}"
    groupdn="${GROUP_DN}"
    groupfilter="${GROUP_FILTER}"
    groupattr="${GROUP_ATTR}"
    insecure_tls=true
EOF
p

vault write auth/ldap/config \
    url="${LDAP_URL}" \
    binddn="${BIND_DN}" \
    bindpass="${BIND_PW}" \
    userdn="${USER_DN}" \
    userattr="${USER_ATTR}" \
    groupdn="${GROUP_DN}" \
    groupfilter="${GROUP_FILTER}" \
    groupattr="${GROUP_ATTR}" \
    insecure_tls=true