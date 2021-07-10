# Vault OpenLDAP Secrets Engine

This demo is for showing off how to configure and use the OpenLDAP secrets engine for Vault. This demo will show both static and dynamic roles.

## Prerequisites

- Docker
- Vault server running in dev mode `vault server -dev -dev-root-token-id=root`

## Procedure

- run `0_launch_ldap.sh` to launch ldap container
- run demos in numbered order
- run `docker stop vault-openldap-demo` when finished to stop ldap container
