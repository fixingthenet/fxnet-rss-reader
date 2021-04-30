class AppConfigurationResource < ApplicationResource
  attribute :configuration, :hash
  # never do this:  attribute :secrets, :hash

end
