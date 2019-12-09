# frozen_string_literal: true

class TestModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

# For MyNumber
class TestUser < TestModel
  validates :my_number, my_number: true
end

class StrictTestUser < TestModel
  validates :my_number, my_number: { strict: true }
end

class StrictDividerTestUser < TestModel
  validates :my_number, my_number: { strict: true, divider: '-' }
end

class TestUserAllowBlank < TestModel
  validates :my_number, my_number: { strict: true, allow_blank: true }
end

class TestUserAllowBlankFalse < TestModel
  validates :my_number, my_number: { allow_blank: false }
end

class TestUserWithMessage < TestModel
  validates :my_number, my_number: { message: 'is not looking very good!' }
end

# For CorporateNumber
class TestCorporation < TestModel
  validates :corporate_number, corporate_number: true
end

class StrictTestCorporation < TestModel
  validates :corporate_number, corporate_number: { strict: true }
end

class StrictDividerTestCorporation < TestModel
  validates :corporate_number, corporate_number: { strict: true, divider: '-' }
end

class TestCorporationAllowBlank < TestModel
  validates :corporate_number, corporate_number: { strict: true, allow_blank: true }
end

class TestCorporationAllowBlankFalse < TestModel
  validates :corporate_number, corporate_number: { allow_blank: false }
end

class TestCorporationWithMessage < TestModel
  validates :corporate_number, corporate_number: { message: 'is not looking very good!' }
end
