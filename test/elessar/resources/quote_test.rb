require "test/unit"
require "mocha/test_unit"
require "elessar"
require "elessar/resources"

module Elessar
  class QuoteTest < Test::Unit::TestCase
    def setup
      @quote_id = "123"
      @quote_data = { dialog: "I'm here!" }
      @http_resp = OpenStruct.new(code: 200, body: [@quote_data, @quote_data].to_json)
      @quote = Quote.new(@quote_id, @quote_data)
    end

    def test_initialize
      assert_equal(@quote_id, @quote.id)
      assert_equal(@quote_data, @quote.data)
    end

    def test_resource_url
      assert_equal("quote", Quote.resource_url)
      assert_equal("quote", @quote.resource_url)
    end

    def test_list
      Elessar::Quote.stubs(:request).returns(ElessarResponse.from_net_http(@http_resp))

      quote = Elessar::Quote.list()
      assert_equal(nil, quote.id)
      assert_equal(@quote_data[:dialog], quote.data.first.dialog)
    end
  end
end
