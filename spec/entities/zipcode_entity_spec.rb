# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ZipcodeEntity do
  subject(:entity) { build(:zipcode_entity) }

  describe '#attributes' do
    it { is_expected.to have_attributes(zipcode: '29018128') }

    it { is_expected.to have_attributes(state: 'ES') }

    it { is_expected.to have_attributes(city: 'Vitoria') }

    it { is_expected.to have_attributes(neighborhood: 'Parque Moscoso') }

    it { is_expected.to have_attributes(street: 'Rua Loren Reno') }

    it { is_expected.to have_attributes(service: 'correios') }

    it { is_expected.to have_attributes(error: nil) }
  end

  describe '#valid?' do
    subject(:valid?) { build(:zipcode_entity, error: error).valid? }

    context 'when is valid' do
      let(:error) { nil }

      it { is_expected.to be_truthy }
    end

    context 'when is invalid' do
      let(:error) { 'Error' }

      it { is_expected.to be_falsey }
    end
  end
end
