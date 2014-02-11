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

require 'capybara/rails'
require 'capybara/mechanize'

class IntegrationHelper < MiniTest::Spec
  include Capybara::DSL

  after do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
MiniTest::Spec.register_spec_type( /Integration$/, IntegrationHelper )

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[File.join("./test/support/**/*.rb")].sort.each { |f| require f }

class DummyHelperClass < ActionView::Base
  include Rails.application.routes.url_helpers
end

MinitestVcr::Spec.configure!

# Capybar ssl
require 'selenium-webdriver'
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 180
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => http_client)
end
Capybara.app_host = "https://localhost:3001"

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  # c.ignore_localhost = true
  c.ignore_request do |request|
    URI(request.uri).port == 7055 || request.uri.match(/__identify__/)

  end
end


# class Mechanize::HTTP::Agent
#   MAX_RESET_RETRIES = 10

#   # We need to replace the core Mechanize HTTP method:
#   #
#   #   Mechanize::HTTP::Agent#fetch
#   #
#   # with a wrapper that handles the infamous "too many connection resets"
#   # Mechanize bug that is described here:
#   #
#   #   https://github.com/sparklemotion/mechanize/issues/123
#   #
#   # The wrapper shuts down the persistent HTTP connection when it fails with
#   # this error, and simply tries again. In practice, this only ever needs to
#   # be retried once, but I am going to let it retry a few times
#   # (MAX_RESET_RETRIES), just in case.
#   #
#   def fetch_with_retry(
#     uri,
#     method    = :get,
#     headers   = {},
#     params    = [],
#     referer   = current_page,
#     redirects = 0
#   )
#     action      = "#{method.to_s.upcase} #{uri.to_s}"
#     retry_count = 0

#     begin
#       fetch_without_retry(uri, method, headers, params, referer, redirects)
#     rescue Net::HTTP::Persistent::Error => e
#       # Pass on any other type of error.
#       raise unless e.message =~ /too many connection resets/

#       # Pass on the error if we've tried too many times.
#       if retry_count >= MAX_RESET_RETRIES
#         puts "**** WARN: Mechanize retried connection reset #{MAX_RESET_RETRIES} times and never succeeded: #{action}"
#         raise
#       end

#       # Otherwise, shutdown the persistent HTTP connection and try again.
#       puts "**** WARN: Mechanize retrying connection reset error: #{action}"
#       retry_count += 1
#       self.http.shutdown
#       retry
#     end
#   end

#   # Alias so #fetch actually uses our new #fetch_with_retry to wrap the
#   # old one aliased as #fetch_without_retry.
#   alias_method :fetch_without_retry, :fetch
#   alias_method :fetch, :fetch_with_retry
# end

# require 'webrick/https'
# require 'rack/handler/webrick'

# def run_ssl_server(app, port)

#   opts = {
#     :Port => port,
#     :SSLEnable => true,
#     :SSLVerifyClient => OpenSSL::SSL::VERIFY_NONE,
#     :SSLPrivateKey => OpenSSL::PKey::RSA.new("./test/support/server.key"),
#     :SSLCertificate => OpenSSL::X509::Certificate.new(File.read "./test/support/server.crt"),
#     :SSLCertName => [["US", 'localhost']],
#     :AccessLog => [],
#     :Logger => WEBrick::Log::new(Rails.root.join("./log/capybara_test.log").to_s)
#   }

#   Rack::Handler::WEBrick.run(app, opts)
# end

# Capybara.server do |app, port|
#   run_ssl_server(app, port)
# end

# Capybara.server_port = 3001
# Capybara.app_host = "https://localhost:%d" % Capybara.server_port

# Capybara.register_driver :webkit do |app|
#   driver = Capybara::Webkit::Driver.new(app)
#   driver.browser.ignore_ssl_errors
#   driver
# end
