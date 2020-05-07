# frozen_string_literal: true

module RadixEncoding
  class Encoding
    module Chunks
      def chunk_bitsize
        raise NotImplementedError
      end

      def chunks_total_bitsize_for(bits)
        count_chunks_in(bits) * chunk_bitsize
      end

      def count_chunks_in(bits)
        (bits.size / chunk_bitsize.to_f).ceil
      end
    end
  end
end
