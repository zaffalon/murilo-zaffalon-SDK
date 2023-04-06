require "test/unit"
require "elessar"
require "elessar/api_operations/request"
require "elessar/connection_manager"
require "mocha/test_unit"

module Elessar
  class RequestTest < Test::Unit::TestCase
    class TestRequest
      include Elessar::APIOperations::Request
    end

    def setup
      @test_request = TestRequest.new
    end

    def test_instance_request
      method = :get
      url = "/test"
      params = { key: "value" }
      opts = { "Content-Type" => "application/json" }

      Elessar::ConnectionManager.any_instance.stubs(:execute_request).returns("response")

      response = @test_request.request(method, url, params, opts)
      assert_equal("response", response)
    end

    def test_class_request
      method = :get
      url = "/test"
      params = { key: "value" }
      opts = { "Content-Type" => "application/json" }

      Elessar::ConnectionManager.any_instance.stubs(:execute_request).returns("response")

      response = TestRequest.request(method, url, params, opts)
      assert_equal("response", response)
    end
  end
end
