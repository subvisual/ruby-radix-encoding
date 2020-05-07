# frozen_string_literal: true

require "active_support/core_ext/object/blank"
require "subvisual/array_utils"

module RadixEncoding
  class Encoding
    module EncodedPoints
      def alphabet
        raise NotImplementedError
      end

      def count_encoded_points_in(bitsize)
        bitsize / encoded_point_bitsize
      end

      def encoded_point_bitsize
        raise NotImplementedError
      end

      def encoded_points_for(bits)
        bits.
          each_slice(encoded_point_bitsize).
          map do |encoded_point_bits|
            encoded_point_index = encoded_point_bits.join.to_i(2)

            alphabet[encoded_point_index]
          end
      end

      def pad_encoded_points(encoded_points, padding_size)
        return encoded_points if padding.blank?

        padded_size = encoded_points.size + padding_size

        Subvisual::ArrayUtils.pad_right(encoded_points, padded_size, padding)
      end

      def padding
        raise NotImplementedError
      end
    end
  end
end
