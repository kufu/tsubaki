require 'spec_helper'

describe Tsubaki::MyNumberValidator do
  describe 'validation' do
    context 'given the valid my numbers' do
      %w(
        000000000000
        111111111111
        222222222222).each do |num|
        it "#{num} should be valid" do
          expect(TestUser.new(my_number: num)).to be_valid
        end
      end
    end
  end

  describe 'nil my_number' do
    it 'should not be valid when :allow_nil option is missing' do
      expect(TestUser.new(my_number: nil)).not_to be_valid
    end
    it 'should be valid when :allow_nil options is set to true' do
      expect(TestUserAllowsNil.new(my_number: nil)).to be_valid
    end
    it 'should not be valid when :allow_nil option is set to false' do
      expect(TestUserAllowsNilFalse.new(my_number: nil)).not_to be_valid
    end
  end
end
