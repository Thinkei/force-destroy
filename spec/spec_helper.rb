ENV["RAILS_ENV"] = "test"

require 'rails/all'

require 'factory_girl'
require 'factory_girl_rails'
require 'rspec/rails'
require 'database_cleaner'

require 'support/dummy_app/config/environment'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'force/destroy'
require 'byebug'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each do |file|
  next if file.include?('support/dummy_app') # skip the dummy app
  require file
end


ActiveRecord::Migration.maintain_test_schema!
ActiveRecord::Schema.verbose = false
load 'support/dummy_app/db/schema.rb'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.lint
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata)
  end

  config.before(:each) do |example|
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
