# Allow encoding of SSN
path "transform/encode/fraud-detection" {
    capabilities = ["update"]
}

# Allow decoding using any of the decode formats
path "transform/decode/fraud-detection/*" {
    capabilities = ["update"]
}

# Allow decoding without specifying a decode format
path "transform/decode/fraud-detection" {
    capabilities = ["update"]
}