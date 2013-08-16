# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Hoo::Application.initialize!

::ActiveSupport::Deprecation.silenced = true