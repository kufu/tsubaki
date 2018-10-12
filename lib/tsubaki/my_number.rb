module Tsubaki
  class MyNumber
    def self.rand
      n = 11
      digits = format("%0#{n}d", SecureRandom.random_number(10**n))
      check_digit = calc_check_digit(digits)
      "#{digits}#{check_digit}"
    end

    def self.calc_check_digit(digits)
      raise 'must be a 11 digit number' unless digits =~ /\A\d{11}\z/

      arr = digits.chars.map(&:to_i).reverse!
      rem = (1..11).inject(0) do |sum, n|
        pn = arr[n - 1]
        qn = n <= 6 ? (n + 1) : (n - 5)
        sum + pn * qn
      end % 11

      rem <= 1 ? 0 : (11 - rem)
    end

    def initialize(digits, options = {})
      @digits = digits.to_s.freeze
      @options = options
    end

    def valid?
      @options[:strict] ? valid_check_digit? : valid_pattern?
    end

    def valid_pattern?
      !!(plain_digits =~ /\A\d{12}\z/)
    end

    def valid_check_digit?
      return false unless valid_pattern?

      plain_digits[-1].to_i == self.class.calc_check_digit(plain_digits[0, 11]).to_i
    end

    private

    def plain_digits
      @plain_digits ||= @digits.split(@options[:divider]).join('')
    end
  end
end
