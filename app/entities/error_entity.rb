# frozen_string_literal: true

ErrorEntity = Struct.new(:body, :type, keyword_init: true) do
  self::HTTP_TYPE = {
    not_found: :not_found,
    record_invalid: :unprocessable_entity,
    attribute_assignment_error: :bad_request,
    internal_server_error: :internal_server_error
  }

  def to_http
    [body, (self.class::HTTP_TYPE[type] || type)]
  end
end
