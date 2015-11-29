module Tsubaki
  module Shoulda
    module Matchers
      # Ensures that the given instance or class validates the format of
      # the corporate number as specified.
      #
      # Example:
      #   describe Corporation do
      #     it { should validate_corporate_number_of(:digits)
      #     it { should validate_corporate_number_of(:digits).strict.with_divider('-') }
      #   end
      def validate_corporate_number_of(attribute_name)
        ValidateCorporateNumberOfMatcher.new(attribute_name)
      end

      class ValidateCorporateNumberOfMatcher
        def initialize(attribute_name)
          @attribute_name = attribute_name
          @options = {}
          @options[:strict] = nil
          @options[:divider] = nil
          @options[:allow_nil] = nil
          @failure_messages = []
          self
        end

        def matches?(subject)
          @subject = subject
          @subject = @subject.new if @subject.class == Class
          (error_when_not_valid + no_error_when_valid).all?
        end

        def failure_message
          @failure_messages.join("\n")
        end

        def description
          result = 'ensure corporate number format'
          result << " for #{@attribute_name}"
          result << ' with strict mode' if @options[:strict].present?
          result << " with divider '#{@options[:divider]}'" if @options[:divider].present?
          result << ' and allow nil' if @options[:allow_nil].present?
          result
        end

        def strict(strict = true)
          @options[:strict] = strict
          self
        end

        def with_divider(divider)
          @options[:divider] = divider
          self
        end

        def allow_nil(allow_nil = true)
          @options[:allow_nil] = allow_nil
          self
        end

        protected

        def error_when_not_valid
          [error_test_allow_nil, error_test_strict, error_test_divider, error_test]
        end

        def no_error_when_valid
          [no_error_test_allow_nil, no_error_test_strict, no_error_test_divider, no_error_test]
        end

        private

        def valid_attribute_with?(value)
          dup_subject = @subject.dup
          dup_subject.send("#{@attribute_name}=", value)
          dup_subject.valid?
          dup_subject.errors[@attribute_name].blank?
        end

        def error_test_allow_nil
          true
        end

        def error_test_strict
          return true if @options[:strict].nil?

          if valid_attribute_with?('1111111111111')
            @failure_messages << 'strict mode is not be specified'
            false
          else
            true
          end
        end

        def error_test_divider
          return true if @options[:divider].nil?

          dummy_divider = @options[:divider].succ
          invalid_corporate_number = "7#{dummy_divider}1234#{dummy_divider}5678#{dummy_divider}9012"

          if valid_attribute_with?(invalid_corporate_number)
            @failure_messages << "divider is not be specified or is not '#{@options[:divider]}'"
            false
          else
            true
          end
        end

        def error_test
          if valid_attribute_with?('xaaaabbbbcccc')
            @failure_messages << 'corporate number validation is not specified'
            false
          else
            true
          end
        end

        def no_error_test_allow_nil
          return true if @options[:allow_nil].nil?

          if !valid_attribute_with?(nil)
            @failure_messages << 'allow_nil is not be specified'
            false
          else
            true
          end
        end

        def no_error_test_strict
          true
        end

        def no_error_test_divider
          return true if @options[:divider].nil?

          valid_corporate_number = "7#{@options[:divider]}1234#{@options[:divider]}5678#{@options[:divider]}9012"

          if !valid_attribute_with?(valid_corporate_number)
            @failure_messages << "divider is not be specified or is not '#{@options[:divider]}'"
            false
          else
            true
          end
        end

        def no_error_test
          if !valid_attribute_with?('7123456789012')
            @failure_messages << 'corporate number validation is not specified'
            false
          else
            true
          end
        end
      end
    end
  end
end
