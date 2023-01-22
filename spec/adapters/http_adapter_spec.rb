# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpAdapter do
  shared_examples 'a post request' do
    subject(:post) { described_class.post(url, payload, custom_headers) }

    before do
      stub_request(:post, url)
        .with(body: payload.to_json)
        .to_return(body: body.to_json, status: 200)
    end

    it { expect(post.body).to include(body) }

    it { expect(post.status).to eq 200 }

    it do
      post
      expect(
        a_request(:post, url).with(body: payload.to_json, headers: headers.merge(custom_headers))
      ).to have_been_made
    end
  end

  shared_examples 'a get request' do
    subject(:get) { described_class.get(url, custom_headers) }

    before do
      stub_request(:get, url)
        .with(headers: headers.merge(custom_headers))
        .to_return(body: body.to_json, status: 200)
    end

    it { expect(get.status).to eq 200 }

    it do
      get
      expect(
        a_request(:get, url).with(headers: headers.merge(custom_headers))
      ).to have_been_made
    end
  end

  describe '#get' do
    let(:headers) do
      {
        'Accept' => 'application/hal+json',
        'Content-Type' => 'application/json',
      }
    end

    let(:url) { 'https://www.zipcode.test' }

    let(:body) { { 'status' => 'ok' } }

    context 'with default headers' do
      let(:custom_headers) { {} }

      it_behaves_like 'a get request'
    end
  end

  describe '#post' do
    let(:headers) do
      {
        'Accept' => 'application/hal+json',
        'Content-Type' => 'application/json',
      }
    end

    let(:url) { 'https://www.zipcode.test' }

    let(:payload) { { foo: 'bar' } }

    let(:body) { { 'status' => 'ok' } }

    context 'with default headers' do
      let(:custom_headers) { {} }

      it_behaves_like 'a post request'
    end

    context 'with custom headers' do
      let(:custom_headers) { { 'Foo' => 'Bar' } }

      it_behaves_like 'a post request'
    end
  end
end
