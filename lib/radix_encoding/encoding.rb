# frozen_string_literal: true

require "subvisual/math_utils"

require "radix_encoding/encoding/bits"
require "radix_encoding/encoding/chunks"
require "radix_encoding/encoding/encoded_points"
require "radix_encoding/encoding/errors"
require "radix_encoding/encoding/validations"

module RadixEncoding
  class Encoding
    include Bits
    include Chunks
    include EncodedPoints
    include Validations

    attr_reader :alphabet, :padding, :radix

    def initialize(alphabet:, radix:, padding: nil)
      @alphabet = alphabet
      @padding = padding
      @radix = radix

      validate!
    end

    def encode(data)
      case data
      when String
        encode_bytes(data.bytes)
      else
        raise DataTypeNotSupportedError.new(data_type: data.class)
      end
    end

    private

    attr_reader :lower_bound, :upper_bound

    def chunk_bitsize
      @chunk_bitsize ||=
        Subvisual::MathUtils.least_common_denominator(lower_power, 8)
    end

    def clean_encoded_points(encoded_points, padding_size)
      return encoded_points unless padding_size.positive?

      encoded_points[0...-padding_size]
    end

    def encode_bytes(bytes)
      bits = bits_for(bytes)
      padded_bitsize = chunks_total_bitsize_for(bits)
      padding_count = count_encoded_points_in(padded_bitsize - bits.size)

      encoded = pad_bits(bits, padded_bitsize)
      encoded = encoded_points_for(encoded)
      encoded = clean_encoded_points(encoded, padding_count)
      encoded = pad_encoded_points(encoded, padding_count)
      encoded = encoded.join
      encoded
    end

    def encoded_point_bitsize
      @encoded_point_bitsize ||= chunk_bitsize / encoded_points_per_chunk
    end

    def encoded_points_per_chunk
      @encoded_points_per_chunk ||= chunk_bitsize / lower_power
    end

    def lower_power
      @lower_power ||= if radix == 2**upper_power
                         upper_power
                       else
                         upper_power - 1
                       end
    end

    def upper_power
      @upper_power ||= begin
                         power = 0
                         power += 1 while 2**power < radix
                         power
                       end
    end
  end
end
