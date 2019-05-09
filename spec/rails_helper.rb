ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f } # helpers

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include ApiHelper, type: :request
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with :deletion
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
