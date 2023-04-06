require "test/unit"
require "elessar"
require "elessar/connection_manager"
require "net/http"

module Elessar
  class ConnectionManagerTest < Test::Unit::TestCase
    def setup
      @config = Elessar.config
      @connection_manager = ConnectionManager.new(@config)
    end

    def test_initialize
      assert_equal(@config, @connection_manager.config)
    end

    def test_connection_for
      uri = "https://www.google.com"
      connection1 = @connection_manager.connection_for(uri)
      connection2 = @connection_manager.connection_for(uri)

      assert_kind_of(Net::HTTP, connection1)
      assert_equal(connection1, connection2)
    end

    def test_authorization_headers
      api_key = "test_api_key"
      Elessar.api_key = api_key
      expected_headers = {
        "Authorization" => "Bearer #{api_key}",
        "Content-Type" => "application/json",
      }

      assert_equal(expected_headers, @connection_manager.authorization_headers)
    end

    def test_execute_request_errors
      invalid_method = "GET"
      invalid_uri = 123
      invalid_body = { key: "value" }
      invalid_headers = "invalid_headers"
      invalid_query = 456

      assert_raise(ArgumentError) { @connection_manager.execute_request(invalid_method, "/", query: "") }
      assert_raise(ArgumentError) { @connection_manager.execute_request(:get, invalid_uri, query: "") }
      assert_raise(ArgumentError) { @connection_manager.execute_request(:get, "/", body: invalid_body, query: "") }
      assert_raise(ArgumentError) { @connection_manager.execute_request(:get, "/", headers: invalid_headers, query: "") }
      assert_raise(ArgumentError) { @connection_manager.execute_request(:get, "/", query: invalid_query) }
    end
  end
end
