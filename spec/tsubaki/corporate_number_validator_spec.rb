require 'spec_helper'

describe Tsubaki::CorporateNumberValidator do
  describe 'validation w/o any options' do
    context 'given the valid Corporation numbers' do
      %w(
        1111111111111
        2222222222222
        3333333333333).each do |num|
        it "#{num} should be valid" do
          expect(TestCorporation.new(corporate_number: num)).to be_valid
        end
      end
    end
    context 'given the invalid Corporation numbers' do
      %w(
        012345678912
        111111111111X
        22222222222222).each do |num|
        it "#{num} should be invalid" do
          expect(TestCorporation.new(corporate_number: num)).to be_invalid
        end
      end
    end
  end

  describe 'validation w/ strict option' do
    context 'given the valid Corporation numbers' do
      %w(
        5835678256246
        7123456789012).each do |num|
        it "#{num} should be valid" do
          expect(StrictTestCorporation.new(corporate_number: num)).to be_valid
        end
      end
    end
    context 'given the invalid Corporation numbers' do
      %w(
        1111111111111
        2222222222222
        3333333333333).each do |num|
        it "#{num} should be invalid" do
          expect(StrictTestCorporation.new(corporate_number: num)).to be_invalid
        end
      end
    end
  end

  describe 'validation w/ strict and divider option' do
    context 'given the valid Corporation numbers' do
      %w(
        5-8356-7825-6246
        7--1234--5678--9012).each do |num|
        it "#{num} should be valid" do
          expect(StrictDividerTestCorporation.new(corporate_number: num)).to be_valid
        end
      end
    end
    context 'given the invalid Corporation numbers' do
      %w(
        1111111111111
        2222222222222
        3333333333333).each do |num|
        it "#{num} should be invalid" do
          expect(StrictDividerTestCorporation.new(corporate_number: num)).to be_invalid
        end
      end
    end
  end

  describe 'nil corporate_number' do
    it 'should not be valid when :allow_blank option is missing' do
      expect(TestCorporation.new(corporate_number: nil)).not_to be_valid
    end
    it 'should be valid when :allow_blank options is set to true' do
      expect(TestCorporationAllowBlank.new(corporate_number: nil)).to be_valid
    end
    it 'should not be valid when :allow_blank option is set to false' do
      expect(TestCorporationAllowBlankFalse.new(corporate_number: nil)).not_to be_valid
    end
  end
end
