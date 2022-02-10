#!/usr/bin/env bash
. env.sh

pe "vault policy write fraud-detection policies/fraud-detection.hcl"
pe "vault policy read fraud-detection"
pe "vault policy write customer-service policies/customer-service.hcl"
pe "vault policy read customer-service"
pe "vault policy write customer policies/customer.hcl"
pe "vault policy read customer"