# frozen_string_literal: true

require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require_relative './setup_test_database'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
                                                                 SimpleCov::Formatter::Console
                                                               ])
SimpleCov.start

RSpec.configure do |config|
  ENV['ENVIRONMENT'] = 'test'

  config.before(:each) do
    setup_test_database
  end

  require File.join(File.dirname(__FILE__), '..', 'app.rb')

  Capybara.app = BookmarkManager

  srand RSpec.configuration.seed
end
