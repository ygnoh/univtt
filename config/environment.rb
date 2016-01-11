# Load environment variables
environment_variables = File.expand_path('../environment_variables.rb', __FILE__)
load(environment_variables) if File.exists?(environment_variables)

# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
