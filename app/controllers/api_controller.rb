class ApiController < ActionController::API
  before_action :authenticate!
  include Fxnet::Graphiti::Controller


  def current_user
    return @current_user if defined?(@current_user)
    app_configuration = Rails.configuration.app_configuration_picker.call(self)
    issuer=app_configuration.configuration['oidc_issuer']


    provider = Oidc::Provider.find_by!(issuer: issuer)
    id_token_string=request.headers['Authorization'].match(/Token token="(.*)"$/)[1]
    @@config ||= provider.config

    id_token = OpenIDConnect::ResponseObject::IdToken.decode id_token_string, @@config.jwks
    #verify
    valid=id_token.aud==provider.identifier &&
          id_token.iss==provider.issuer &&
          id_token.sub.present? &&
          Time.at(id_token.iat) > 1.days.ago # we don't use exp as google only issues 1h idToken
    logger.debug("IdToken: #{id_token_string} #{@@config.jwks.inspect} valid:#{valid}")

    if valid
      @current_user = provider.user(id_token)
    else
      @current_user = nil
    end
  end

  private

  def authenticate!
    current_user || raise(Fxnet::Errors::NotAuthenticated)
  end

end
