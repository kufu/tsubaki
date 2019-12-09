# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'tsubaki'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
