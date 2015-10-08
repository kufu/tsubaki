module Tsubaki
  class MyNumber
    attr_reader :errros

    def initialize(digits, options = {})
      @errors = []
      @digits = digits
      @digits.gsub!(options[:divider], '') if options[:divider]
      @errors << :invalid unless @digits =~ /\A\d{12}\z/
    end

    def valid?
      @errors.empty?
    end

    def valid_check_digits?
      @digits = @digits.to_s.chars.map(&:to_i)
      return false unless @digits.length == 12

      expected_check_digit = @digits.pop
      @digits.reverse!
      remainder = (1..11).inject(0) do |sum, n|
        pn = @digits[n - 1]
        qn = (n <= 6) ? (n + 1) : (n - 5)
        sum + pn * qn
      end % 11

      actual_check_digit = remainder <= 1 ? 0 : (11 - remainder)

      actual_check_digit == expected_check_digit
    end
  end
end
