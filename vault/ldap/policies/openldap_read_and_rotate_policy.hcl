# Allow read-only and static cred rotation for OpenLDAP secrets engine
path "openldap/*" {
  capabilities = [ "read" ]
}

path "openldap/rotate-role/*" {
  capabilities = [ "update" ]
}
