# frozen_string_literal: true

module Elessar
  class ElessarResponseHeaders
    def self.from_net_http(resp)
      new(resp.to_hash || resp.to_h)
    end

    def initialize(hash)
      return if hash.nil?
      @hash = {}

      hash.each do |k, v|
        @hash[k.downcase] = v
      end
    end
  end

  module ElessarResponseBase
    attr_accessor :http_headers
    attr_accessor :http_status

    def self.populate_for_net_http(resp, http_resp)
      resp.http_headers = ElessarResponseHeaders.from_net_http(http_resp)
      resp.http_status = http_resp.code.to_i
    end
  end

  class ElessarResponse
    include ElessarResponseBase

    attr_accessor :data
    attr_accessor :http_body

    def self.from_net_http(http_resp)
      resp = ElessarResponse.new
      resp.data = JSON.parse(http_resp.body, object_class: OpenStruct)
      resp.http_body = http_resp.body
      ElessarResponseBase.populate_for_net_http(resp, http_resp)
      resp
    end
  end

  ElessarResponse::Headers = ElessarResponseHeaders
end
