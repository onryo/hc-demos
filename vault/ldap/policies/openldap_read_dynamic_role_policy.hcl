# Only allow access to single 'dynamic role' for OpenLDAP secrets engine
path "openldap/creds/dynamic-role" {
  capabilities = [ "read" ]
}
