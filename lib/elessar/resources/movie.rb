# frozen_string_literal: true

module Elessar
  class Movie
    include Elessar::APIOperations::Request

    attr_accessor :id, :data

    def initialize(id, data = {})
      @id = id
      @data = data
    end

    OBJECT_NAME = "movie"

    def self.retrieve(id, opts = {})
      url = resource_url + "/#{id}"
      resp = request(:get, url, params = nil, opts = opts)
      new(id, resp.data)
    end

    def self.list(filters = { limit: 10 }, opts = {})
      resp = request(:get, resource_url, params = filters, opts = opts)
      new(nil, resp.data)
    end

    def list_quotes(filters = { limit: 10 }, opts = {})
      url = "#{resource_url}/#{id}/quote"
      resp = request(:get, url, params = filters, opts = opts)
      Elessar::Quote.new(nil, resp.data)
    end

    def self.resource_url
      "#{OBJECT_NAME}"
    end

    def resource_url
      "#{OBJECT_NAME}"
    end
  end
end
