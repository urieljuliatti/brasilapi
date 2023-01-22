# frozen_string_literal: true

FactoryBot.define do
  factory :zipcode_entity, class: 'ZipcodeEntity' do
    zipcode { '29018128' }
    state { 'ES' }
    city { 'Vitoria' }
    neighborhood { 'Parque Moscoso' }
    street { 'Rua Loren Reno' }
    service { 'correios' }
  end
end
