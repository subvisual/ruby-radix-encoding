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

      def bits_from_encoded_points(encoded_points)
        encoded_points.
          map do |encoded_point|
            alphabet.
              index(encoded_point).
              to_s(2).
              rjust(encoded_point_bitsize, "0")
          end.
          join.
          chars
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

      def unpad_encoded_points(encoded_points)
        first_padding_index = encoded_points.index(padding)

        return encoded_points if first_padding_index.nil?

        encoded_points[0...first_padding_index]
      end
    end
  end
end
