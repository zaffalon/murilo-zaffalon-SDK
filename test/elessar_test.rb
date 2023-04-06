require "test/unit"
require "elessar"

module Elessar
  class ElessarTest < Test::Unit::TestCase
    def test_api_key
      api_key = "test_api_key"
      Elessar.api_key = api_key
      assert_equal(api_key, Elessar.api_key)
    end

    def test_api_version
      api_version = "2023-01-01"
      Elessar.api_version = api_version
      assert_equal(api_version, Elessar.api_version)
    end

    def test_api_base
      api_base = "https://api.example.com"
      Elessar.api_base = api_base
      assert_equal(api_base, Elessar.api_base)
    end

    def test_open_timeout
      open_timeout = 10
      Elessar.open_timeout = open_timeout
      assert_equal(open_timeout, Elessar.open_timeout)
    end

    def test_read_timeout
      read_timeout = 10
      Elessar.read_timeout = read_timeout
      assert_equal(read_timeout, Elessar.read_timeout)
    end

    def test_max_network_retries
      max_network_retries = 3
      Elessar.max_network_retries = max_network_retries
      assert_equal(max_network_retries, Elessar.max_network_retries)
    end
  end
end
