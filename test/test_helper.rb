if RUBY_ENGINE == "ruby"
  begin
    require "simplecov"
    SimpleCov.start "rails" do
      add_filter "test"
      add_filter "config"
      command_name "MiniTest"
      add_group "Services", "app/services"
    end
    SimpleCov.merge_timeout 3600
  rescue LoadError
    warn "unable to load SimpleCov"
  end
end

ENV["RAILS_ENV"] = "test"
require 'dotenv'
Dotenv.load ".env.test"
require File.expand_path("../../config/environment", __FILE__)

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[File.join("./test/support/**/*.rb")].sort.each { |f| require f }

require "thincloud-test-rails"

require 'capybara/rails'

class IntegrationHelper < MiniTest::Spec
  include Capybara::DSL
  include SignInHelper

  after do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

MiniTest::Spec.register_spec_type( /Integration$/, IntegrationHelper )

class DummyHelperClass < ActionView::Base
  include Rails.application.routes.url_helpers
end

MinitestVcr::Spec.configure!

# # Capybar ssl
# require 'selenium-webdriver'
# Capybara.default_driver = :selenium
# Capybara.register_driver :selenium do |app|
#   http_client = Selenium::WebDriver::Remote::Http::Default.new
#   http_client.timeout = 180
#   Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => http_client)
# end
# Capybara.app_host = "https://localhost:3001"

