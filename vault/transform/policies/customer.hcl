# Allow encoding of SSN
path "transform/encode/customer" {
    capabilities = ["update"]
}

# Allow decoding using only the last-four decode format
path "transform/decode/customer/last-four" {
    capabilities = ["update"]
}