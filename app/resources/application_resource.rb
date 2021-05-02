# ApplicationResource is similar to ApplicationRecord - a base class that
# holds configuration/methods for subclasses.
# All Resources should inherit from ApplicationResource.
class ApplicationResource < Graphiti::Resource
  # Use the ActiveRecord Adapter for all subclasses.
  # Subclasses can still override this default.
  self.abstract_class = true
  self.adapter = Graphiti::Adapters::ActiveRecord
  self.base_url = ENV["HOST"]
  self.endpoint_namespace = '/api/v1'
  self.validate_endpoints = false

  def current_user
    @current_user ||= context.current_user
  end

  def logger
    Rails.logger
  end
end
