# frozen_string_literal: true

require "radix_encoding/encoding"
require "radix_encoding/version"

module RadixEncoding
  # Standard Base32 encoding as defined in RFC 4648.
  BASE32 = Encoding.new(
    alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567",
    radix: 32,
    padding: "=",
  )

  # Standard Base64 encoding as defined in RFC 4648.
  BASE64 = Encoding.new(
    alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
    radix: 64,
    padding: "=",
  )
end
