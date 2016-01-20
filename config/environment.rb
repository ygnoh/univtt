# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load environment variables
environment_variables = File.join(Rails.root, 'config', 'environment_variables.rb')
load(environment_variables) if File.exists?(environment_variables)

# Initialize the Rails application.
Rails.application.initialize!
