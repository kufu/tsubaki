# frozen_string_literal: true

module Tsubaki
  module Shoulda
    module Matchers
      # Ensures that the given instance or class validates the format of
      # the my number as specified.
      #
      # Example:
      #   describe User do
      #     it { should validate_my_number_of(:digits) }
      #     it { should validate_my_number_of(:digits).strict.with_divider('-') }
      #   end
      #
      #   describe AnotherUser do
      #     it { should validate_my_number_of(:digits).on(:create) }
      #   end
      def validate_my_number_of(attribute_name)
        ValidateMyNumberOfMatcher.new(attribute_name)
      end

      class ValidateMyNumberOfMatcher
        def initialize(attribute_name)
          @attribute_name = attribute_name
          @options = {}
          @options[:strict] = nil
          @options[:divider] = nil
          @options[:allow_nil] = nil
          @options[:on] = nil
          @failure_messages = []
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
          result = 'ensure my number format'
          result += " for #{@attribute_name}"
          result += ' with strict mode' if @options[:strict].present?
          result += " with divider '#{@options[:divider]}'" if @options[:divider].present?
          result += ' and allow blank' if @options[:allow_blank].present?
          result += " on #{@options[:on]}" if @options[:on].present?
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

        def on(on)
          @options[:on] = on
          self
        end

        private

        def error_when_not_valid
          [error_test_allow_nil, error_test_strict, error_test_divider, error_test]
        end

        def no_error_when_valid
          [no_error_test_allow_nil, no_error_test_strict, no_error_test_divider, no_error_test]
        end

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

          if valid_attribute_with?('111111111111')
            @failure_messages << 'strict mode is not be specified'
            false
          else
            true
          end
        end

        def error_test_divider
          return true if @options[:divider].nil?

          dummy_divider = @options[:divider].succ
          invalid_my_number = "9656#{dummy_divider}7219#{dummy_divider}7231"

          if valid_attribute_with?(invalid_my_number)
            @failure_messages << "divider is not be specified or is not '#{@options[:divider]}'"
            false
          else
            true
          end
        end

        def error_test
          if valid_attribute_with?('aaaabbbbcccc')
            @failure_messages << 'my number validation is not specified'
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

          valid_my_number = "9656#{@options[:divider]}7219#{@options[:divider]}7231"

          if !valid_attribute_with?(valid_my_number)
            @failure_messages << "divider is not be specified or is not '#{@options[:divider]}'"
            false
          else
            true
          end
        end

        def no_error_test
          if !valid_attribute_with?('965672197231')
            @failure_messages << 'my number validation is not specified'
            false
          else
            true
          end
        end
      end
    end
  end
end
