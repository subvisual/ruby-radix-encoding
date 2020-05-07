# frozen_string_literal: true

require "radix_encoding/encoding/errors"

module RadixEncoding
  class Encoding
    module Validations
      def alphabet
        raise NotImplementedError
      end

      def radix
        raise NotImplementedError
      end

      def validate!
        validate_alphabet_length!
      end

      def validate_alphabet_length!
        return if alphabet.bytesize >= radix

        raise AlphabetTooShortError.new(
          alphabet_bytesize: alphabet.bytesize,
          radix: radix,
        )
      end
    end
  end
end
