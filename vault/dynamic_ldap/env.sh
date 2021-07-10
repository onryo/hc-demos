# Environment variables for this local demo

LDAP_ORGANISATION="learn"
LDAP_DOMAIN="learn.example"
LDAP_HOST=${LDAP_HOST:-127.0.0.1}
LDAP_URL="ldap://${LDAP_HOST}"
BIND_DN=${BIND_DN:-"cn=admin,dc=learn,dc=example"}
BIND_PW=${BIND_PW:-"2LearnVault"}
USER_DN=${USER_DN:-"ou=users,dc=learn,dc=example"}
USER_ATTR=${USER_ATTR:-"cn"}
DEMO_USER_DN=${DEMO_USER_DN:-"cn=static-role-demo-user,ou=users,dc=learn,dc=example"}
DEMO_USER_NAME=${DEMO_USER_NAME:-"static-role-demo-user"}
DEMO_USER_PW=${DEMO_USER_PW:-"1LearnedVault"}

# Demo Magic tooling
# Demo magic gives wrappers for running commands in demo mode.   Also good for learning via CLI.

export PATH=${PATH}:../../demo-tools

# This is for the time to wait when using demo_magic.sh
if [[ -z ${DEMO_WAIT} ]];then
  DEMO_WAIT=0
fi

. demo-magic.sh -d -p -w ${DEMO_WAIT}
