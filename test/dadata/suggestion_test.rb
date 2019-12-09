# frozen_string_literal: true

require 'test_helper'

class Dadata::SuggestionTest < Minitest::Test
  def setup
    @term = FFaker::Company.name
    @url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party'

    @config = { api_key: FFaker::Lorem.characters }
    @subject = Dadata::Suggestion.new(@config)
  end

  def test_organization_returns_true_with_hash_when_ok
    json = File.read(File.expand_path('../support/suggestion_organization.json',
                                      __dir__))
    stub_request(:post, @url)
      .with(body: { query: @term }.to_json)
      .and_return(status: 200, body: json)

    ok, result = @subject.organization(@term)

    assert ok
    assert_equal JSON.parse(json, symbolize_names: true), result
  end

  def test_organization_returns_false_with_message_when_error
    code = 401
    message = 'Unauthorized access'
    stub_request(:post, url)
      .with(body: { query: @term }.to_json)
      .and_return(status: code, body: message)

    ok, result = @subject.organization(@term)

    assert !ok
    assert_equal({ code: code, message: message }, result)
  end
end
