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
require File.expand_path("../../config/environment", __FILE__)

require "thincloud-test-rails"

# Requires supporting ruby files with custom matchers and macros, etc,
# in test/support/ and its subdirectories.
Dir[File.join("./test/support/**/*.rb")].sort.each { |f| require f }

class DummyHelperClass < ActionView::Base
  include Rails.application.routes.url_helpers
end

# Dynamically creates the directory structure and yml files for VCR
class MiniTest::Spec
  before :each do |example|
    test_info = example.class.name.split("::").map {|e| e.underscore}
    name = example.__name__.underscore.gsub(/[^\w\/]+/, "_")
    path = "test/cassettes/" + [test_info[0], test_info[1]].join("/")
    FileUtils.mkdir_p(path) unless File.exists?(path)
    VCR.configure do |c|
      c.cassette_library_dir = path
    end
    VCR.insert_cassette name
  end

  after :each do
    VCR.eject_cassette
    VCR.configure do |c|
      c.cassette_library_dir = 'test/cassettes'
    end
  end
end
