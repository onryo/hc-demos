#!/bin/bash

. env.sh

pe "vault audit enable file file_path=/tmp/vault_audit.log"

green "Tail Vault audit logs with the following command...\n"
echo "docker exec -t vault-demo /usr/bin/tail -f /tmp/vault_audit.log | jq"
