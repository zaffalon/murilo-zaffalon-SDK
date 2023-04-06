require "test/unit"
require "mocha/test_unit"
require "elessar"
require "elessar/resources"

module Elessar
  class MovieTest < Test::Unit::TestCase
    def setup
      @movie_id = "123"
      @movie_data = { title: "Test Movie", year: 2022 }
      @movie = Movie.new(@movie_id, @movie_data)
      @http_resp = OpenStruct.new(code: 200, body: @movie_data.to_json)
      @http_list_resp = OpenStruct.new(code: 200, body: [@movie_data, @movie_data].to_json)
      @quote_data = { dialog: "I'm Here" }
      @http_list_quote_resp = OpenStruct.new(code: 200, body: [@quote_data, @quote_data].to_json)
    end

    def test_initialize
      assert_equal(@movie_id, @movie.id)
      assert_equal(@movie_data, @movie.data)
    end

    def test_resource_url
      assert_equal("movie", Movie.resource_url)
      assert_equal("movie", @movie.resource_url)
    end

    def test_retrieve
      Elessar::Movie.stubs(:request).returns(ElessarResponse.from_net_http(@http_resp))

      movie = Elessar::Movie.retrieve(@movie_id)
      assert_equal(@movie_id, movie.id)
      assert_equal(@movie_data[:title], movie.data.title)
    end

    def test_list
      Elessar::Movie.stubs(:request).returns(ElessarResponse.from_net_http(@http_list_resp))

      movie = Elessar::Movie.list()
      assert_equal(nil, movie.id)
      assert_equal(@movie_data[:title], movie.data.first.title)
    end

    def test_list_quotes(filters = { limit: 10 }, opts = {})
      Elessar::Movie.stubs(:request).returns(ElessarResponse.from_net_http(@http_resp))
      Elessar::Movie.any_instance.stubs(:request).returns(ElessarResponse.from_net_http(@http_list_quote_resp))

      movie = Elessar::Movie.retrieve(@movie_id)
      assert_equal(@movie_id, movie.id)
      assert_equal(@movie_data[:title], movie.data.title)

      quote = movie.list_quotes()
      assert_equal(nil, quote.id)
      assert_equal(@quote_data[:dialog], quote.data.first.dialog)
    end
  end
end
