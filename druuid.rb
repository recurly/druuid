require 'securerandom'

# = Druuid
#
# Date-relative UUID generation.
module Druuid

  class << self

    # The offset from which Druuid UUIDs are generated (in seconds).
    attr_accessor :epoch

    # Generates a time-sortable, 64-bit UUID.
    #
    # @example
    #   Druuid.gen
    #   # => 11142943683383068069
    # @param [Time] time of UUID
    # @param [Numeric] epoch offset
    # @return [Bignum] UUID
    def gen time = Time.now, epoch_offset = epoch
      ms = ((time.to_f - epoch_offset.to_i) * 1e3).round
      rand = (SecureRandom.random_number * 1e16).round
      id = ms << (64 - 41)
      id | rand % (2 ** (64 - 41))
    end

    # Determines when a given UUID was generated.
    #
    # @param [Numeric] uuid
    # @param [Numeric] epoch offset
    # @return [Time] when UUID was generated
    # @example
    #   Druuid.time 11142943683383068069
    #   # => 2012-02-04 00:00:00 -0800
    def time uuid, epoch_offset = epoch
      ms = uuid >> (64 - 41)
      Time.at(ms / 1e3) + epoch_offset.to_i
    end

    # Provides lower bound id based on datetime provided.
    #
    # @param [Time] time of lower bound id
    # @return [BigNum] Lower Bound ID
    # @example
    #   Druuid.gen_lower_bound Time.utc(2015,2,3,12,2,34)
    # #=> 11936695196844032000
    def gen_lower_bound time
      gen(time) >> (64 - 41) << (64 - 41)
    end

    # Provides upper bound id based on datetime provided.
    #
    # @param [Time] time of upper bound id
    # @return [BigNum] Upper Bound ID
    # @example
    #   Druuid.gen_upper_bound Time.utc(2015,2,3,17,56,12)
    # #=> 11936873186336964607
    def gen_upper_bound time
      gen(time) | 0b111_1111_1111_1111_1111_1111
    end

    # Provides lower and upper bound ids based on datetime range provided.
    #
    # @param [Range] datetime range for upper and lower bound ids
    # @return [Range] ids of lower and upper bound range
    # @example
    #   Druuid.gen_range Time.utc(2015,2,3,12,2,34), Time.utc(2015,2,3,17,56,12)
    #   # => 11936695196844032000..11936873186336964607
    def gen_range datetime_range
      gen_lower_bound(datetime_range.begin)..gen_upper_bound(datetime_range.end)
    end

  end

end
