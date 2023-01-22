# frozen_string_literal: true

ZipcodeEntity = Struct.new(
  :zipcode,
  :state,
  :city,
  :neighborhood,
  :street,
  :service,
  keyword_init: true) do

  attr_accessor :error

  def valid?
    error.nil?
  end
end
