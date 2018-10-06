module Tsubaki
  class CorporateNumber
    def self.rand
      digits = 12.times.map { Kernel.rand(10) }.join
      check_digit = calc_check_digit(digits)
      "#{check_digit}#{digits}"
    end

    def self.calc_check_digit(digits)
      raise 'must be a 12 digit number' unless digits =~ /\A\d{12}\z/

      arr = digits.chars.map(&:to_i).reverse!
      rem = (1..12).inject(0) do |sum, n|
        pn = arr[n - 1]
        qn = n.odd? ? 1 : 2
        sum + pn * qn
      end % 9

      9 - rem
    end

    def initialize(digits, options = {})
      @digits = digits.to_s.freeze
      @options = options
    end

    def valid?
      @options[:strict] ? valid_check_digit? : valid_pattern?
    end

    def valid_pattern?
      !!(plain_digits =~ /\A\d{13}\z/)
    end

    def valid_check_digit?
      return false unless valid_pattern?

      plain_digits[0].to_i == self.class.calc_check_digit(plain_digits[1, 12]).to_i
    end

    private

    def plain_digits
      @plain_digits ||= @digits.split(@options[:divider]).join('')
    end
  end
end
