require 'spec_helper'


abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation


RSpec.configure do |config|
  config.include Capybara::DSL
  config.infer_spec_type_from_file_location!
  
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
