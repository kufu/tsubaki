require 'spec_helper'

describe Tsubaki::MyNumber do
  describe '#valid?' do
    subject { Tsubaki::MyNumber.new(digits, options).valid? }
    context 'when digits contains divider & not strict mode' do
      let(:digits) { '1111-2222-3333' }
      let(:options) { { divider: '-', strict: false } }
      it { is_expected.to be_truthy }
    end
  end

  describe '#valid_check_digits?' do
    subject { Tsubaki::MyNumber.new(digits, {}).valid_check_digits? }
    context 'given the valid my numbers' do
      %w(
        023456789013
        123456789018
        123456789018).each do |n|
        let(:digits) { n }
        it "#{n} should be valid" do
          is_expected.to be_truthy
        end
      end
    end
    context 'given the invalid my numbers' do
      %w(
        123456789010
        123456789011
        123456789012).each do |n|
        let(:digits) { n }
        it "#{n} should be invalid" do
          is_expected.to be_falsy
        end
      end
    end
  end
end
