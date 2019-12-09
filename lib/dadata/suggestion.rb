# frozen_string_literal: true

require 'json'
require 'net/http'

module Dadata
  # Suggestion API
  class Suggestion
    BASE_URL = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/'

    def initialize(config)
      @config = config
    end

    def organization(term)
      url = URI(URI.join(BASE_URL, 'party'))

      req = Net::HTTP::Post.new(url)

      req['Content-Type'] = 'application/json'
      req['Accept'] = 'application/json'
      req['Authorization'] = "Token #{@config[:api_key]}"

      req.body = { query: term }.to_json

      resp = perform_request(url, req)

      if resp.code == '200'
        [true, JSON.parse(resp.body, symbolize_names: true)]
      else
        [false, code: resp.code.to_i, message: resp.body]
      end
    end

    private

    def perform_request(url, request)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.request(request)
    end
  end
end
