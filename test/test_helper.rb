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

require "thincloud-test-rails"

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[File.join("./test/support/**/*.rb")].sort.each { |f| require f }

class DummyHelperClass < ActionView::Base
  include Rails.application.routes.url_helpers
end

MinitestVcr::Spec.configure!
