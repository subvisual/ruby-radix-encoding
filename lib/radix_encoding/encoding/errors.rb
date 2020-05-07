# frozen_string_literal: true

module RadixEncoding
  class Encoding
    class AlphabetTooShortError < StandardError
      def initialize(alphabet_bytesize:, radix:)
        super <<~MESSAGE
          The provided alphabet is too short. It has #{alphabet_bytesize}
          bytes, must have at least #{radix} bytes.
        MESSAGE
      end
    end

    class DataTypeNotSupportedError < StandardError
      def initialize(data_type:)
        super <<~MESSAGE
          The provided data is of a not supported type #{data_type}. Only
          String is supported.
        MESSAGE
      end
    end
  end
end
