# frozen_string_literal: true

module Elessar
  class Quote
    include Elessar::APIOperations::Request

    attr_accessor :id, :data

    def initialize(id, data = {})
      @id = id
      @data = data
    end

    OBJECT_NAME = "quote"

    def self.list(filters = { limit: 10 }, opts = {})
      resp = request(:get, resource_url, params = filters, opts = opts)
      new(nil, resp.data)
    end

    def self.resource_url
      "#{OBJECT_NAME}"
    end

    def resource_url
      "#{OBJECT_NAME}"
    end
  end
end
