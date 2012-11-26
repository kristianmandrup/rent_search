# See http://reinteractive.net/posts/2-start-your-engines

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  # By including Capybara like this, we make the methods from this module 
  # available in all specs in the spec/integration directory, but no other.
  config.include Capybara, :example_group => { :file_path => /\bspec\/integration\// }  
end

# lacking the Rake task to put it on Rubygems. We can add these Rake tasks to our project by adding this line to our Rakefile:

# Bundler::GemHelper.install_tasks

# Rakefile
# s.files = `git ls-files`.split("\n")