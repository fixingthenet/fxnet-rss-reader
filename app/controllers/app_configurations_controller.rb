class AppConfigurationsController < ApiController
  skip_before_action :authenticate!
#  def index
#    app_configurations = AppConfigurationResource.all(params)
#    respond_with(app_configurations)
#  end

  def show
    app_configuration = AppConfigurationResource.find(params)
    respond_with(app_configuration)
  end

#  def create
#    app_configuration = AppConfigurationResource.build(params)

#    if app_configuration.save
#      render jsonapi: app_configuration, status: 201
#    else
#      render jsonapi_errors: app_configuration
#    end
#  end

#  def update
#    app_configuration = AppConfigurationResource.find(params)
#
#    if app_configuration.update_attributes
#      render jsonapi: app_configuration
#    else
#      render jsonapi_errors: app_configuration
#    end
#  end

#  def destroy
#    app_configuration = AppConfigurationResource.find(params)
#
#    if app_configuration.destroy
#      render jsonapi: { meta: {} }, status: 200
#    else
#      render jsonapi_errors: app_configuration
#    end
#  end
end
