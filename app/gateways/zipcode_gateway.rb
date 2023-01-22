# frozen_string_literal: true

class ZipcodeGateway

  ZIPCODE_URL = ENV['ZIPCODE_URL'].freeze

  class << self
    def create_zipcode(entity)
      response = HttpAdapter.get(ZIPCODE_URL.merge(entity.zipcode))

      if response.success?
        entity.zipcode = response.body['cep']
        entity.state = response.body['state']
        entity.city = response.body['city']
        entity.neighborhood = response.body['neighborhood']
        entity.street = response.body['street']
        entity.service = response.body['service']
      else
        entity.error = build_error(response)
      end
    end
  end

  private

  def build_error(response)
    { body: response.body.slice('errors'), name: 'CepPromiseError', message: 'Todos os serviços de CEP retornaram erro.', type: 'service_error' }
  end
end
