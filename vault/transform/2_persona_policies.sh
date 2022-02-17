#!/usr/bin/env bash
. env.sh

green "Create the Fraud Detection policy"
pe "vault policy write fraud-detection policies/fraud-detection.hcl"
pe "vault policy read fraud-detection"
wait

green "Create the Customer Service policy"
pe "vault policy write customer-service policies/customer-service.hcl"
pe "vault policy read customer-service"
wait

green "Create the Customer policy"
pe "vault policy write customer policies/customer.hcl"
pe "vault policy read customer"