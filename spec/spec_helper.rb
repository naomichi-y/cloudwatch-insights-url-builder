require 'simplecov'

RSpec.configure do |config|
  SimpleCov.start

  config.expect_with :rspec do |c|
    c.max_formatted_output_length = 1000
  end
end
