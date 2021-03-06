require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/lib/'
  add_filter '/vendor/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Views', 'app/views'
end if ENV["COVERAGE"]

require 'rubygems'
require 'spork'


Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  #require 'rspec/autorun'

  require 'factory_girl_rails'
  require 'capybara/rspec'
  require 'capybara/poltergeist'
  # require 'phantomjs/poltergeist'
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.

  # Capybara.register_driver :poltergeist do |app|
  #   Capybara::Poltergeist::Driver.new(app, js_errors: false, :phantomjs => Phantomjs.path)
  # end
  Capybara.javascript_driver = :poltergeist

  # Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)


  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    # Use factory_girl methods without a class.
    config.include FactoryGirl::Syntax::Methods
    # config.include Features::SessionHelpers, type: :feature

    # Include the Capybara DSL so that specs in spec/requests still work.
    config.include Capybara::DSL

    # Disable the old-style object.should syntax.
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end

    config.include Rails.application.routes.url_helpers

    # Allow setting locale from environment to run tests with different locales
    config.before(:all) do
      I18n.locale = ENV['TEST_LOCALE'] || I18n.default_locale
    end


  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
