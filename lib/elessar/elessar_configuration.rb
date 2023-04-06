# frozen_string_literal: true

module Elessar
  class ElessarConfiguration
    attr_accessor :api_key
    attr_accessor :api_version

    attr_reader :api_base
    attr_reader :max_network_retries
    attr_reader :open_timeout
    attr_reader :read_timeout

    def self.setup
      new.tap do |instance|
        yield(instance) if block_given?
      end
    end

    def initialize
      @max_network_retries = 0

      @open_timeout = 30
      @read_timeout = 80

      @api_base = "https://the-one-api.dev/v2/"
    end

    def max_network_retries=(val)
      @max_network_retries = val.to_i
    end

    def open_timeout=(open_timeout)
      @open_timeout = open_timeout
    end

    def read_timeout=(read_timeout)
      @read_timeout = read_timeout
    end

    def api_base=(api_base)
      @api_base = api_base
    end
  end
end
