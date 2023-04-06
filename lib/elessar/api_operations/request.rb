# frozen_string_literal: true

module Elessar
  module APIOperations
    module Request
      module ClassMethods
        def request(method, url, params = {}, opts = {})
          connection = Elessar::ConnectionManager.new
          connection.execute_request(
            method,
            url,
            query: params,
            headers: opts,
          )
        end
      end

      def request(method, url, params = {}, opts = {})
        connection = Elessar::ConnectionManager.new
        connection.execute_request(
          method,
          url,
          query: params,
          headers: opts,
        )
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
