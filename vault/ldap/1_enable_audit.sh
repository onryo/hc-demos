#!/bin/bash

. env.sh

pe "vault audit enable file file_path=/tmp/vault_audit.log"