# frozen_string_literal: true

require 'securerandom'

require 'test_helper'

class Dadata::SuggestionTest < Minitest::Test
  def setup
    @config = { api_key: FFaker::Lorem.characters }
    @subject = Dadata::Suggestion.new(@config)
  end

  def test_organization_returns_true_with_hash
    term = FFaker::Company.name

    json = File.read(File.expand_path('../support/suggestion_organization.json',
                                      __dir__))
    url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party'
    stub_request(:post, url)
      .with(body: { query: term }.to_json)
      .and_return(status: 200, body: json)

    ok, result = @subject.organization(query: term)

    assert ok
    assert_equal JSON.parse(json, symbolize_names: true)[:suggestions], result
  end

  def test_organization_returns_false_with_message_when_error
    term = FFaker::Company.name

    code = 401
    message = 'Unauthorized access'
    url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party'
    stub_request(:post, url)
      .with(body: { query: term }.to_json)
      .and_return(status: code, body: message)

    ok, result = @subject.organization(query: term)

    refute ok
    assert_equal({ code: code, message: message }, result)
  end

  def test_address_by_fias_id_returns_true_with_hash
    fias_id = SecureRandom.uuid

    json = File.read(
      File.expand_path('../support/suggestion_address_by_fias_id.json',
                       __dir__)
    )
    url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/address'
    stub_request(:post, url)
      .with(body: { query: fias_id }.to_json)
      .and_return(status: 200, body: json)

    ok, result = @subject.address_by_fias_id(fias_id: fias_id)

    assert ok
    assert_equal JSON.parse(json, symbolize_names: true)[:suggestions], result
  end

  def test_address_by_str_returns_true_with_hash
    query = "#{FFaker::Address.street_address}, #{FFaker::Address.city}"

    json = File.read(
      File.expand_path('../support/suggestion_address_by_str.json',
                       __dir__)
    )
    url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address'
    stub_request(:post, url)
      .with(body: { query: query }.to_json)
      .and_return(status: 200, body: json)

    ok, result = @subject.address_by_str(query: query)

    assert ok
    assert_equal JSON.parse(json, symbolize_names: true)[:suggestions], result
  end
end
