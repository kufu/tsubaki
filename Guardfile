# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec', failed_mode: :focus do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :rubocop, all_on_start: true, cli: ['-D', '--format', 'clang'] do
  watch(/.+\.rb$/)
end
