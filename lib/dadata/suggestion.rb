# frozen_string_literal: true

require 'json'
require 'net/http'

module Dadata
  # Suggestion API
  class Suggestion
    BASE_URL = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/'

    def initialize(config)
      @config = config
    end

    def organization(query: term)
      call_method('suggest/party', query: query)
    end

    def address_by_fias_id(query: fias_id)
      call_method('findById/address', query: query)
    end

    private

    def call_method(method, **query_data)
      url = URI(URI.join(BASE_URL, method))

      req = Net::HTTP::Post.new(url)

      req['Content-Type'] = 'application/json'
      req['Accept'] = 'application/json'
      req['Authorization'] = "Token #{@config[:api_key]}"

      req.body = query_data.to_json

      resp = perform_request(url, req)

      if resp.code == '200'
        [true, JSON.parse(resp.body, symbolize_names: true)[:suggestions]]
      else
        [false, { code: resp.code.to_i, message: resp.body }]
      end
    end

    def perform_request(url, request)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.request(request)
    end
  end
end
