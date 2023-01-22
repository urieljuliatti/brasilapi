# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ZipcodeGateway do
  subject(:gateway) { described_class }

  describe 'ZIPCODE_URL' do
    subject(:zipcode_url) { gateway::ZIPCODE_URL }

    it { is_expected.to eq ENV['ZIPCODE_URL'] }
  end

  describe '#create_zipcode' do
    subject(:create_zipcode) { gateway.create_zipcode(entity) }

    let(:entity) { build(:zipcode_entity) }

    before do
      stub_request(:get, gateway::ZIPCODE_URL.merge(entity.zipcode))
    end

    shared_examples 'an invalid request' do
      it { is_expected.to be_falsey }

      it do
        create_zipcode
        expect(entity.error).to eq error
      end
    end
    
    context 'when is valid' do
    
      let(:status) { 200 }
  
      it { is_expected.to be_truthy }
  
      describe 'entity' do
        before { create_zipcode }
  
        it { expect(entity).to have_attributes(zipcode: '29018128') }
  
        it { expect(entity).to have_attributes(state: 'ES') }
      end
    end

  end
end
