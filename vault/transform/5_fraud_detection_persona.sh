#!/usr/bin/env bash
. env.sh

ENCODED_SSN=$(vault write -format=json transform/encode/customer value="123-45-6789" transformation=us-ssn | jq -r ".data.encoded_value")
export VAULT_TOKEN=$(vault token create -format=json -policy="fraud-detection" | jq -r ".auth.client_token")

# Fraud Detection persona
green "Fraud Detection is allowed to perform all encoding and decoding operations"
pe "vault write transform/encode/fraud-detection value=\"123-45-6789\" transformation=us-ssn"
pe "vault write transform/decode/fraud-detection value=\"$ENCODED_SSN\" transformation=us-ssn"
pe "vault write transform/decode/fraud-detection/last-four value=\"$ENCODED_SSN\" transformation=us-ssn"