# frozen_string_literal: true

require "radix_encoding/encoding"

RSpec.describe RadixEncoding::Encoding do
  describe "#initialize" do
    it "raises an error if the alphabet's length is less than the radix" do
      expect do
        RadixEncoding::Encoding.new(radix: 2, alphabet: "a")
      end.to raise_error RadixEncoding::Encoding::AlphabetTooShortError
    end
  end

  describe "#encode" do
    it "raises an error if the data is not a String" do
      encoding = RadixEncoding::Encoding.new(radix: 2, alphabet: "ab")

      expect do
        encoding.encode(2)
      end.to raise_error RadixEncoding::Encoding::DataTypeNotSupportedError
    end
  end
end
