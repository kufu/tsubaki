# frozen_string_literal: true

require 'tsubaki/matchers/validate_my_number_of_matcher'
require 'tsubaki/matchers/validate_corporate_number_of_matcher'

module Tsubaki
  module Shoulda
    # Provides RSpec-compatible & Test::Unit-compatible matchers for testing Tsubaki modules.
    #
    # *RSpec*
    #
    # In spec_helper.rb, you'll need to require the matchers:
    #
    #   require "tsubaki/matchers"
    #
    # And _include_ the module:
    #
    #   RSpec.configure do |config|
    #     config.include Tsubaki::Shoulda::Matchers
    #   end
    #
    # Example:
    #   describe User do
    #     it { should validate_my_number_of(:digits) }
    #     it { should validate_validate_my_number_of(:digits).strict.with_divider('-') }
    #   end
    #
    #
    # *TestUnit*
    #
    # In test_helper.rb, you'll need to require the matchers as well:
    #
    #   require "tubaki/matchers"
    #
    # And _extend_ the module:
    #
    #   class ActiveSupport::TestCase
    #     extend Tsubaki::Shoulda::Matchers
    #
    #     #...other initializers...#
    #   end
    #
    # Example:
    #   require 'test_helper'
    #
    #   class UserTest < ActiveSupport::TestCase
    #     should validate_validate_my_number_of(:digits)
    #     should validate_validate_my_number_of(:digits).strict.with_divider('-')
    #   end
    #
    module Matchers
    end
  end
end
