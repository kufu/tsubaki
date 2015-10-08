class TestModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

class TestUser < TestModel
  validates :my_number, my_number: true
end

class StrictTestUser < TestModel
  validates :my_number, my_number: { strict: true }
end

class TestUserAllowsNil < TestModel
  validates :my_number, my_number: { allow_nil: true }
end

class TestUserAllowsNilFalse < TestModel
  validates :my_number, my_number: { allow_nil: false }
end

class TestUserWithMessage < TestModel
  validates :my_number, my_number: { message: 'is not looking very good!' }
end
