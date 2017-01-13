require 'securerandom'

# = Druuid
#
# Date-relative UUID generation.
module Druuid
  NUM_RANDOM_BITS = 64 - 41

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
      id = ms << NUM_RANDOM_BITS
      id | rand % (2 ** NUM_RANDOM_BITS)
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
      ms = uuid >> NUM_RANDOM_BITS
      Time.at(ms / 1e3) + epoch_offset.to_i
    end

    # Determines the minimum UUID that could be generated for the given time.
    #
    # @param [Time] time of UUID
    # @param [Numeric] epoch offset
    # @return [Bignum] UUID
    # @example
    #   Druuid.min_for_time
    #   # => 11142943683379200000
    def min_for_time time = Time.now, epoch_offset = epoch
      ms = ((time.to_f - epoch_offset.to_i) * 1e3).round
      ms << NUM_RANDOM_BITS
    end

  end

end
