require 'active_model'
require 'active_model/validator'

module Tsubaki
  class MyNumberValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      return if Tsubaki::MyNumber.new(value, options).valid?
      record.errors[attribute] << (options[:message] || :invalid)
    end
  end
end

ActiveModel::Validations::MyNumberValidator = Tsubaki::MyNumberValidator
