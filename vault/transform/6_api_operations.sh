#!/usr/bin/env bash
. env.sh

ENCODED_SSN=$(vault write -format=json transform/encode/fraud-detection value="123-45-6789" transformation=us-ssn | jq -r ".data.encoded_value")
export VAULT_TOKEN=$(vault token create -format=json -policy="fraud-detection" | jq -r ".auth.client_token")

green "Applications can implement format-preserving encryption with Vault's API"
yellow "API operations are performed using the Fraud Detection persona"
echo

# encode SSN
green "Encode SSN with POST request to /v1/transform/encode/fraud-detection"
cat << EOF
curl
    --header "X-Vault-Token: $VAULT_TOKEN"
    --request POST
    --data '{"value": "123-45-6789", "transformation": "us-ssn" }'
    $VAULT_ADDR/v1/transform/encode/fraud-detection
EOF
p

curl -s \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data '{"value": "123-45-6789", "transformation": "us-ssn" }' \
    $VAULT_ADDR/v1/transform/encode/fraud-detection | jq
wait

# decode SSN
echo
green "Decode SSN with POST request to /v1/transform/decode/fraud-detection"
cat << EOF
curl
    --header "X-Vault-Token: $VAULT_TOKEN"
    --request POST
    --data '{"value": "'$ENCODED_SSN'", "transformation": "us-ssn" }'
    $VAULT_ADDR/v1/transform/decode/fraud-detection
EOF
p

curl -s \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data '{"value": "'$ENCODED_SSN'", "transformation": "us-ssn" }' \
    $VAULT_ADDR/v1/transform/decode/fraud-detection | jq
wait

# decode SSN last-four
echo
green "Decode last four of SSN with POST request to /v1/transform/decode/fraud-detection/last-four"
cat << EOF
curl
    --header "X-Vault-Token: $VAULT_TOKEN"
    --request POST
    --data '{"value": "'$ENCODED_SSN'", "transformation": "us-ssn" }'
    $VAULT_ADDR/v1/transform/decode/fraud-detection/last-four
EOF
p

curl -s \
    --header "X-Vault-Token: $VAULT_TOKEN" \
    --request POST \
    --data '{"value": "'$ENCODED_SSN'", "transformation": "us-ssn" }' \
    $VAULT_ADDR/v1/transform/decode/fraud-detection/last-four | jq