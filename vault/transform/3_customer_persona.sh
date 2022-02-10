#!/usr/bin/env bash
. env.sh

ENCODED_SSN=$(vault write -format=json transform/encode/customer value="123-45-6789" transformation=us-ssn | jq -r ".data.encoded_value")
export VAULT_TOKEN=$(vault token create -format=json -policy="customer" | jq -r ".auth.client_token")

# Customer persona
yellow "Customers are allowed to encode their SSN and decode the last-four digits"
pe "vault write transform/encode/customer value=\"123-45-6789\" transformation=us-ssn"
pe "vault write transform/decode/customer/last-four value=\"$ENCODED_SSN\" transformation=us-ssn"

yellow "Customers are not allowed to fully decode SSN"
pe "vault write transform/decode/customer value=\"$ENCODED_SSN\" transformation=us-ssn"


