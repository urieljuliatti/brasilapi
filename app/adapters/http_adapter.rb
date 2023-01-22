# frozen_string_literal: true

module HttpAdapter

  module_function

  HEADERS = {
    'Accept' => 'application/hal+json',
    'Content-Type' => 'application/json'
  }.freeze

  def post(url, payload, headers = {})
    conn.post(url, payload, HEADERS.merge(headers))
  end

  def get(url, params = nil, headers = {})
    conn.get(url, params, HEADERS.merge(headers))
  end

  def conn
    Faraday.new do |faraday|
      faraday.request  :json
      faraday.response :json
      faraday.adapter :typhoeus
    end
  end
end
