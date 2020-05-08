# frozen_string_literal: true

require "subvisual/array_utils"

module RadixEncoding
  class Encoding
    module Bits
      def bits_for(bytes)
        bytes.
          map do |byte|
            byte.
              # Convert the byte (a number) to a string with its binary form
              to_s(2).
              # Pad the result with leading zeros to represent all the bits
              rjust(8, "0")
          end.
          # Join all the bits strings
          join.
          # Split the string into an array of characters (each is a bit)
          chars
      end
    end

    def bytes_for(bits)
      bits.each_slice(8).map do |byte_bits|
        byte_bits.join.to_i(2)
      end
    end

    def pad_bits(bits, padded_bitsize)
      Subvisual::ArrayUtils.pad_right(bits, padded_bitsize, "0")
    end

    def unpad_bits(bits)
      excess_bits = bits.size % 8

      return bits if excess_bits.zero?

      bits[0...-excess_bits]
    end
  end
end
