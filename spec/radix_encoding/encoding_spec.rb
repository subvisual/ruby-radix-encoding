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

    context "when encoding has a prefix" do
      it "returns a string starting with the prefix" do
        prefix = Faker::Lorem.word
        digest_hex_encoding = RadixEncoding::Encoding.new(
          alphabet: "0123456789abcdef",
          prefix: prefix,
          radix: 16,
        )

        encoded = digest_hex_encoding.encode(Faker::Lorem.sentence)

        expect(encoded).to start_with prefix
      end
    end
  end

  describe "#decode" do
    context "when encoding has a prefix" do
      it "ignores the prefix at the start of the string" do
        data = Faker::Lorem.sentence
        encoded = Digest.hexencode(data)
        prefix = Faker::Lorem.word
        digest_hex_encoding = RadixEncoding::Encoding.new(
          alphabet: "0123456789abcdef",
          prefix: prefix,
          radix: 16,
        )

        decoded = digest_hex_encoding.decode(prefix + encoded)

        expect(decoded).to eq data
      end

      it "ignores the prefix if the string does not start with it" do
        data = Faker::Lorem.sentence
        encoded = Digest.hexencode(data)
        digest_hex_encoding = RadixEncoding::Encoding.new(
          alphabet: "0123456789abcdef",
          prefix: Faker::Lorem.word,
          radix: 16,
        )

        decoded = digest_hex_encoding.decode(encoded)

        expect(decoded).to eq data
      end
    end
  end
end
