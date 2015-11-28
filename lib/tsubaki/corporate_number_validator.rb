require 'active_model'
require 'active_model/validator'

module Tsubaki
  class CorporateNumberValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if Tsubaki::CorporateNumber.new(value, options).valid?
      record.errors.add(attribute, options[:message] || :invalid)
    end
  end
end

ActiveModel::Validations::CorporateNumberValidator = Tsubaki::CorporateNumberValidator
