# frozen_string_literal: true

module Elessar
  class ConnectionManager
    attr_reader :config

    def initialize(config = Elessar.config)
      @config = config
      @active_connections = {}
    end

    def connection_for(uri)
      u = URI.parse(uri)
      connection = @active_connections[[u.host, u.port]]

      if connection.nil?
        connection = create_connection(u)
        connection.start

        @active_connections[[u.host, u.port]] = connection
      end

      connection
    end

    def authorization_headers
      headers = {
        "Authorization" => "Bearer #{Elessar.api_key}",
        "Content-Type" => "application/json",
      }
    end

    def execute_request(method, uri, body: nil, headers: {}, query:, &block)
      raise ArgumentError, "method should be a symbol" unless method.is_a?(Symbol)
      raise ArgumentError, "uri should be a string" unless uri.is_a?(String)
      raise ArgumentError, "body should be a string" if body && !body.is_a?(String)
      raise ArgumentError, "headers should be a hash" if headers && !headers.is_a?(Hash)
      raise ArgumentError, "query should be a hash or string" if query && (!query.is_a?(Hash) and !query.is_a?(String))

      headers = headers.merge(authorization_headers)
      uri = Elessar.api_base + uri

      connection = connection_for(uri)

      u = URI.parse(uri)
      path = case query
        when String
          u.path + "?" + query
        when Hash
          u.path + "?" + URI.encode_www_form(query)
        else
          u.path
        end

      method_name = method.to_s.upcase
      has_response_body = method_name != "HEAD"
      request = Net::HTTPGenericRequest.new(
        method_name,
        (body ? true : false),
        has_response_body,
        path,
        headers
      )

      http_resp = begin
          retries ||= 0
          connection.request(request, body, &block)
        rescue
          retry if (retries += 1) < Elessar.max_network_retries
        end

      begin
        resp = ElessarResponse.from_net_http(http_resp)
      rescue JSON::ParserError
        raise general_api_error(http_resp.code.to_i, http_resp.body)
      end
    end

    private def create_connection(uri)
      connection = Net::HTTP.new(uri.host, uri.port)

      connection.use_ssl = true
      connection.keep_alive_timeout = 30
      connection.open_timeout = config.open_timeout
      connection.read_timeout = config.read_timeout

      connection
    end

    private def general_api_error(status, body)
      StandardError.new("Invalid response object from API: #{body.inspect} " \
      "(HTTP response code was #{status})")
    end
  end
end
