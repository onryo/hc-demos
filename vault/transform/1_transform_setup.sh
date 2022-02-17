#!/usr/bin/env bash
. env.sh

green "Configuration of the transform secrets engine will performed using the root token"
yellow "This is not normal for most operations with Vault and only illustrates basic usage journeys"

green "Enable the transform secrets engine at transform/"
pe "vault secrets enable transform"
wait

green "Create a template for US serial numbers, which allows for \"SSN:\" or \"ssn:\" prefixes"
cat << EOF
vault write transform/template/us-ssn
  type=regex
  pattern='(?:SSN[: ]?|ssn[: ]?)?(\d{3})[- ]?(\d{2})[- ]?(\d{4})'
  encode_format='\$1-\$2-\$3'
  decode_formats=last-four='*** ** \$3'
  alphabet=builtin/numeric
EOF
p

vault write transform/template/us-ssn \
  type=regex \
  pattern='(?:SSN[: ]?|ssn[: ]?)?(\d{3})[- ]?(\d{2})[- ]?(\d{4})' \
  encode_format='$1-$2-$3' \
  decode_formats=last-four='*** ** $3' \
  alphabet=builtin/numeric
wait

echo
green "Create transformation for SSN with internal tweak source"
cat << EOF
vault write transform/transformations/fpe/us-ssn
  template="us-ssn"
  tweak_source=internal
  allowed_roles=fraud-detection,customer-service,customer
EOF
p

vault write transform/transformations/fpe/us-ssn \
  template="us-ssn" \
  tweak_source=internal \
  allowed_roles=fraud-detection,customer-service,customer
wait

echo
green "Create roles for each of our personas"
pe "vault write transform/role/fraud-detection transformations=us-ssn"
pe "vault write transform/role/customer-service transformations=us-ssn"
pe "vault write transform/role/customer transformations=us-ssn"

pe "vault list transform/role"

