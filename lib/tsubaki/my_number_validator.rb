require 'active_model'
require 'active_model/validator'

module Tsubaki
  class MyNumberValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << (options[:message] || :invalid) unless value =~ /\A\d{12}\z/
    end
  end
end

ActiveModel::Validations::MyNumberValidator = Tsubaki::MyNumberValidator
