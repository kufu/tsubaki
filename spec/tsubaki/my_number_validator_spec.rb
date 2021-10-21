# frozen_string_literal: true

require 'spec_helper'
require 'tsubaki/matchers/validate_my_number_of_matcher'

describe Tsubaki::MyNumberValidator do
  describe 'validation w/o any options' do
    context 'given the valid my numbers' do
      %w[
        012345678912
        111111111111
        222222222222
      ].each do |num|
        it "#{num} should be valid" do
          expect(TestUser.new(my_number: num)).to be_valid
        end
      end
    end
    context 'given the invalid my numbers' do
      %w[
        01234567891
        11111111111X
        2222222222222
      ].each do |num|
        it "#{num} should be invalid" do
          expect(TestUser.new(my_number: num)).to be_invalid
        end
      end
    end
  end

  describe 'validation w/ strict option' do
    context 'given the valid my numbers' do
      %w[
        465281266333
        191187943353
        116428722815
      ].each do |num|
        it "#{num} should be valid" do
          expect(StrictTestUser.new(my_number: num)).to be_valid
        end
      end
    end
    context 'given the invalid my numbers' do
      %w[
        012345678912
        111111111111
        222222222222
      ].each do |num|
        it "#{num} should be invalid" do
          expect(StrictTestUser.new(my_number: num)).to be_invalid
        end
      end
    end
  end

  describe 'validation w/ strict and divider option' do
    context 'given the valid my numbers' do
      %w[
        465281266333
        1911-8794-3353
        116428--722815
      ].each do |num|
        it "#{num} should be valid" do
          expect(StrictDividerTestUser.new(my_number: num)).to be_valid
        end
      end
    end
    context 'given the invalid my numbers' do
      %w[
        012345678912
        111111111111
        222222222222
      ].each do |num|
        it "#{num} should be invalid" do
          expect(StrictDividerTestUser.new(my_number: num)).to be_invalid
        end
      end
    end
  end

  describe 'nil my_number' do
    it 'should not be valid when :allow_blank option is missing' do
      expect(TestUser.new(my_number: nil)).not_to be_valid
    end
    it 'should be valid when :allow_blank options is set to true' do
      expect(TestUserAllowBlank.new(my_number: nil)).to be_valid
    end
    it 'should not be valid when :allow_blank option is set to false' do
      expect(TestUserAllowBlankFalse.new(my_number: nil)).not_to be_valid
    end
  end

  describe '#on' do
    let(:matcher) do
      Tsubaki::Shoulda::Matchers::ValidateMyNumberOfMatcher.new(:my_number)
    end

    it 'returns itself' do
      expect(matcher.on(:some_context)).to eq(matcher)
    end

    it 'sets options[:on]' do
      expect { matcher.on(:some_context) }
        .to change { matcher.instance_variable_get(:@options)[:on] }
        .from(nil)
        .to(:some_context)
    end
  end
end
