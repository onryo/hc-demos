#!/usr/bin/env bash
. env.sh

ENCODED_SSN=$(vault write -format=json transform/encode/customer-service value="123-45-6789" transformation=us-ssn | jq -r ".data.encoded_value")
export VAULT_TOKEN=$(vault token create -format=json -policy="customer-service" | jq -r ".auth.client_token")

# Customer Service persona
green "Customer Service is allowed to decode the last-four digits for identity verification purposes"
pe "vault write transform/decode/customer-service/last-four value=\"$ENCODED_SSN\" transformation=us-ssn"
wait

red "Customer Service is not allowed to encode or fully decode SSNs"
pe "vault write transform/encode/customer-service value=\"123-45-6789\" transformation=us-ssn"
pe "vault write transform/decode/customer-service value=\"$ENCODED_SSN\" transformation=us-ssn"