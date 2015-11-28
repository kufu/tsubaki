require 'spec_helper'

describe Tsubaki::CorporateNumber do
  describe '.rand' do
    it 'generates valid random corporate number' do
      n = Tsubaki::CorporateNumber.rand
      expect(Tsubaki::CorporateNumber.new(n, strict: true).valid?).to be_truthy
    end
  end

  describe '.calc_check_digit' do
    context 'given invalid digits' do
      [
        nil,
        '123456789012X',
        '1-5678-1111-9018'
      ].each do |n|
        describe "#{n}" do
          it 'raises RuntimeError' do
            expect {
              Tsubaki::CorporateNumber.calc_check_digit(n)
            }.to raise_error(RuntimeError)
          end
        end
      end
    end
    context 'given valid digits' do
      subject { Tsubaki::CorporateNumber.calc_check_digit(digits) }
      describe '835678256246' do
        let(:digits) { '835678256246' }
        it { is_expected.to eq 5 }
      end
      describe '123456789012' do
        let(:digits) { '123456789012' }
        it { is_expected.to eq 7 }
      end
    end
  end

  describe '#valid?' do
    subject { Tsubaki::CorporateNumber.new(digits, options).valid? }
    context 'when digits no options are specified' do
      let(:options) { {} }
      context 'given the valid corporate numbers' do
        %w(
          2835678256246
          1123456789012
        ).each do |n|
          describe "#{n}" do
            let(:digits) { n }
            it { is_expected.to be_truthy }
          end
        end
      end
      context 'given the invalid corporate numbers' do
        [
          nil,
          '312345678901X',
          '4-5678-1111-9018'
        ].each do |n|
          describe "#{n}" do
            let(:digits) { n }
            it { is_expected.to be_falsy }
          end
        end
      end
    end

    context 'when digits contains divider & not strict mode' do
      let(:options) { { divider: '-', strict: false } }
      context 'given the valid corporate numbers' do
        %w(
          1111111111111
          1-1111-1111-1111
        ).each do |n|
          describe "#{n}" do
            let(:digits) { n }
            it { is_expected.to be_truthy }
          end
        end
      end
      context 'given the invalid corporate numbers' do
        [
          nil,
          '3-0234-5678-XXXX',
          '5678-9018'
        ].each do |n|
          describe "#{n}" do
            let(:digits) { n }
            it { is_expected.to be_falsy }
          end
        end
      end
    end
    context 'when digits contains divider & strict mode' do
      let(:options) { { divider: '-', strict: true } }
      context 'given the valid corporate numbers' do
        %w(
          5835678256246
          5-835678256246
          5-8356-7825-6246
        ).each do |n|
          describe "#{n}" do
            let(:digits) { n }
            it { is_expected.to be_truthy }
          end
        end
      end
      context 'given the invalid corporate numbers' do
        [
          nil,
          '4-8356-7825-6246',
          '5678-9018',
          '1234567890123',
          '3-9876-5432-1098',
          '3--112233--445566'
        ].each do |n|
          describe "#{n}" do
            let(:digits) { n }
            it { is_expected.to be_falsy }
          end
        end
      end
    end
  end

  describe '#valid_pattern?' do
    subject { Tsubaki::CorporateNumber.new(digits, {}).valid_pattern? }
    context 'given the valid pattern corporate numbers' do
      %w(
        5835678256246
        1234567890123
      ).each do |n|
        describe "#{n}" do
          let(:digits) { n }
          it 'should be valid' do
            is_expected.to be_truthy
          end
        end
      end
    end
    context 'given the invalid corporate numbers' do
      %w(
        123456789012
        123456789012X
        12345678901234
      ).each do |n|
        describe "#{n}" do
          let(:digits) { n }
          it 'should be invalid' do
            is_expected.to be_falsy
          end
        end
      end
    end
  end

  describe '#valid_check_digit?' do
    subject { Tsubaki::CorporateNumber.new(digits, {}).valid_check_digit? }
    context 'given the valid corporate numbers' do
      %w(
        7123456789012
        5835678256246
      ).each do |n|
        describe "#{n}" do
          let(:digits) { n }
          it 'should be valid' do
            is_expected.to be_truthy
          end
        end
      end
    end
    context 'given the invalid corporate numbers' do
      %w(
        7123456789012
        4835678256246
      ).each do |n|
        describe "#{n}" do
          let(:digits) { n }
          it 'should be invalid' do
            is_expected.to be_falsy
          end
        end
      end
    end
  end
end
