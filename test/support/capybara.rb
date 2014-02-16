DatabaseCleaner.strategy = :truncation

require "capybara/rails"
# require "support/session_helpers"

class AcceptanceTest < Minitest::Unit::TestCase
  include Capybara::DSL
  include Capybara::Assertions
  # include SessionHelpers

  def setup
    Capybara.reset_session!
  end

  def teardown
    DatabaseCleaner.clean_with :truncation
  end
end

class AcceptanceSpec < AcceptanceTest
  extend Minitest::Spec::DSL
end
