$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tsubaki'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
