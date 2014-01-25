source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', git: "git://github.com/rails/rails.git", branch: "4-0-stable"
gem "pg"

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier'
gem 'foundation-rails'
gem "font-awesome-rails"

gem "soft_service", git: "git://github.com/elskwid/soft_service.git"

gem "attr_encrypted"

gem "simple_form"
gem "awesome_print"
gem "pliable",       "~> 0.1.0"

# gem "salesforce_bulk_api", :git => "git@github.com:StepsAway/salesforce_bulk_api.git"
gem "salesforce_bulk"
gem "restforce"
gem "metaforce", git: "git://github.com/mfpiccolo/metaforce.git"

# Salesforce Related Gems:
gem 'databasedotcom-oauth2' #basic rest access to salesforce.com.
# alternative gem interface: https://github.com/ejholmes/restforce
# Salesforce / Heroku / et. all seem to have largely abandoned
# databasedotcom as a project, with several features lacking or
# functionallity falling behind EJHolmes restforce gem. It should
# be noted that Eric (EJHolmes) was the original author of
# databasedotcom (i'm like 99.5% sure of that.)

gem 'databasedotcom-rails', :git => 'git://github.com/noeticpenguin/databasedotcom-rails.git'
# this gem gives you some auto-wizbang
# voodoo to automatically back your controllers with models in
# salesforce. Using this gem allows you to autowire, for instance
# the Opportunity controller in your rails app, to salesforces'
# Opportunity object. You may be asking why the git-version?
# my fork (this git version) allows you to use an externally
# gathered oauth token rather than re-logging in on every call. neat.

gem 'omniauth-salesforce' # 'cause if you're going to go to the work
# of setting up an integration with salesforce for data, you might
# as well be able to authenticate against salesforce as well right?

#Nice to have gems:
gem 'activeadmin', github: 'gregbell/active_admin'
# Nice, Quick, stupid simple dsl and framework
# for "admin" sections in your rails app. Use this, for instance,
# to dynamically adjust which properties or fields your
# databasedotcom-rails model's pull / push to optimize speed!

# PDF generation
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'

#Sys Admin type Gems:
gem 'foreman'
gem 'newrelic_rpm' #Don't be stupid. use newrelic.
gem "hub", ">= 1.10.2", :require => nil, :group => [:development]
gem "figaro", ">= 0.5.3" # Handles creating a github repo for me
gem 'thin', '>= 1.5.0' # http server -- my favorite part of thin
# is that one of their releases was code named "bat shit crazy"

#Authentication, Authorization and Identity Management:
gem "omniauth", ">= 1.1.3"
# gem "omniauth-github"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem 'devise'

group :development, :test do
  gem "thincloud-test", github: "newleaders/thincloud-test", branch: "rails4"
  gem "thincloud-test-rails", github: "newleaders/thincloud-test-rails", branch: "rails4"
  gem "rspec-rails"
  gem "pry",                     "~> 0.9.12.2"
  gem "pry-debugger",            "~> 0.2.2"
  gem "vcr"
  gem "minitest-vcr",            "~> 0.0.2"
  gem "dotenv"
end

group :development do
  gem "better_errors",     "~> 1.0.1"
  gem "binding_of_caller", "~> 0.7.2"
  gem "quiet_assets",      "~> 1.0.2"
end

group :test do
  gem "capybara",                "~> 2.1.0"
  gem "launchy",                 "~> 2.3.0"
  gem "minitest-capybara",       "~> 0.4.1"
  gem "minispec-metadata", "~> 2.0.0"
  gem "capybara_minitest_spec",  "~> 1.0.0"
  gem "poltergeist",             "~> 1.3.0"
  gem "database_cleaner",        "~> 1.0.1"
  gem "webmock",                 "~> 1.8.0"
end

#Testing, Where in a highly opinionated list of Gems is included:
# group :development do
#   gem "better_errors"
#   gem "binding_of_caller"
#   gem "meta_request"
#   gem "quiet_assets"
#   gem "awesome_print"
#   gem "guard"
#   gem "guard-minitest"
#   gem "simplecov"
#   gem "terminal-notifier-guard"
# end

# group :test, :development do
#   gem "rspec-rails"
#   gem "shoulda-matchers"
#   gem "pry"
#   gem "pry-debugger"
#   gem "factory_girl_rails"
#   gem "rb-fsevent"
#   gem "guard-rspec"
#   gem "vcr"
#   gem "jasminerice", :git => 'https://github.com/bradphelan/jasminerice.git'
# end

# group :test do
#   gem "capybara"
#   gem "capybara-firebug"
#   gem "poltergeist"
#   gem "webmock"
# end

