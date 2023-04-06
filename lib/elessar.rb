require "net/http"
require "json"
require "forwardable"

# API operations
require "elessar/api_operations/request"

require "elessar/elessar_configuration"
require "elessar/connection_manager"
require "elessar/elessar_response"

require "elessar/resources"

module Elessar
  @config = Elessar::ElessarConfiguration.setup

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :@config, :api_key, :api_key=
    def_delegators :@config, :api_version, :api_version=
    def_delegators :@config, :api_base, :api_base=
    def_delegators :@config, :open_timeout, :open_timeout=
    def_delegators :@config, :read_timeout, :read_timeout=
    def_delegators :@config, :max_network_retries, :max_network_retries=
  end
end
