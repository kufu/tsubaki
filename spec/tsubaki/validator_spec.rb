require 'spec_helper'

class TestUser < TestModel
  validates :my_number, my_number: true
end

class StrictTestUser < TestModel
  validates :my_number, my_number: {strict: true}
end

class TestUserAllowsNil < TestModel
  validates :my_number, my_number: {allow_nil: true}
end

class TestUserAllowsNilFalse < TestModel
  validates :my_number, my_number: {allow_nil: false}
end

class TestUserWithMessage < TestModel
  validates :my_number, my_number: {message: 'is not looking very good!'}
end

describe Tsubaki::MyNumberValidator do
  describe 'validation' do
    context 'given the valid my numbers' do
      [
        '000000000000',
        '111111111111',
        '222222222222'
      ].each do |num|
        it "#{num} should be valid" do
          expect(TestUser.new(my_number: num)).to be_valid
        end
      end
    end
  end
end
