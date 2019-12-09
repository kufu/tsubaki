# frozen_string_literal: true

require 'spec_helper'

describe Tsubaki::MyNumber do
  describe '.rand' do
    it 'generates valid random my number' do
      n = Tsubaki::MyNumber.rand
      expect(Tsubaki::MyNumber.new(n, strict: true).valid?).to be_truthy
    end
  end

  describe '.calc_check_digit' do
    context 'given invalid digits' do
      [
        nil,
        '12345678901X',
        '5678-1111-9018'
      ].each do |n|
        describe n.to_s do
          it 'raises RuntimeError' do
            expect {
              Tsubaki::MyNumber.calc_check_digit(n)
            }.to raise_error(RuntimeError)
          end
        end
      end
    end
    context 'given valid digits' do
      subject { Tsubaki::MyNumber.calc_check_digit(digits) }
      describe '37296774233' do
        let(:digits) { '37296774233' }
        it { is_expected.to eq 8 }
      end
      describe '29217589598' do
        let(:digits) { '29217589598' }
        it { is_expected.to eq 2 }
      end
    end
  end

  describe '#valid?' do
    subject { Tsubaki::MyNumber.new(digits, options).valid? }
    context 'when digits no options are specified' do
      let(:options) { {} }
      context 'given the valid my numbers' do
        %w[
          123456789012
          987654321098
          112233445566
        ].each do |n|
          describe n.to_s do
            let(:digits) { n }
            it { is_expected.to be_truthy }
          end
        end
      end
      context 'given the invalid my numbers' do
        [
          nil,
          '12345678901X',
          '5678-1111-9018'
        ].each do |n|
          describe n.to_s do
            let(:digits) { n }
            it { is_expected.to be_falsy }
          end
        end
      end
    end

    context 'when digits contains divider & not strict mode' do
      let(:options) { { divider: '-', strict: false } }
      context 'given the valid my numbers' do
        %w[
          123456789012
          9876-5432-1098
          112233--445566
        ].each do |n|
          describe n.to_s do
            let(:digits) { n }
            it { is_expected.to be_truthy }
          end
        end
      end
      context 'given the invalid my numbers' do
        [
          nil,
          '0234-5678-XXXX',
          '5678-9018'
        ].each do |n|
          describe n.to_s do
            let(:digits) { n }
            it { is_expected.to be_falsy }
          end
        end
      end
    end
    context 'when digits contains divider & strict mode' do
      let(:options) { { divider: '-', strict: true } }
      context 'given the valid my numbers' do
        %w[
          873321641958
          2633-4829-1158
          491131--223718
        ].each do |n|
          describe n.to_s do
            let(:digits) { n }
            it { is_expected.to be_truthy }
          end
        end
      end
      context 'given the invalid my numbers' do
        [
          nil,
          '0234-5678-XXXX',
          '5678-9018',
          '123456789012',
          '9876-5432-1098',
          '112233--445566'
        ].each do |n|
          describe n.to_s do
            let(:digits) { n }
            it { is_expected.to be_falsy }
          end
        end
      end
    end
  end

  describe '#valid_pattern?' do
    subject { Tsubaki::MyNumber.new(digits, {}).valid_pattern? }
    context 'given the valid pattern my numbers' do
      %w[
        023456789013
        123456789018
        333333333333
      ].each do |n|
        describe n.to_s do
          let(:digits) { n }
          it 'should be valid' do
            is_expected.to be_truthy
          end
        end
      end
    end
    context 'given the invalid my numbers' do
      %w[
        12345678901
        12345678901X
        1234567890123
      ].each do |n|
        describe n.to_s do
          let(:digits) { n }
          it 'should be invalid' do
            is_expected.to be_falsy
          end
        end
      end
    end
  end

  describe '#valid_check_digit?' do
    subject { Tsubaki::MyNumber.new(digits, {}).valid_check_digit? }
    context 'given the valid my numbers' do
      %w[
        185672239885
        176521275740
        654629853731
      ].each do |n|
        describe n.to_s do
          let(:digits) { n }
          it 'should be valid' do
            is_expected.to be_truthy
          end
        end
      end
    end
    context 'given the invalid my numbers' do
      %w[
        185672239886
        176521275741
        654629853732
      ].each do |n|
        describe n.to_s do
          let(:digits) { n }
          it 'should be invalid' do
            is_expected.to be_falsy
          end
        end
      end
    end
  end
end
