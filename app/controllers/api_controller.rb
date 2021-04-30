class ApiController < ActionController::API
  before_action :authenticate!
  include Fxnet::Graphiti::Controller
  
  private
  
  def authenticate!
    current_user || raise(Fxnet::Errors::NotAuthenticated)
  end

  def current_user
    return @current_user if defined?(@current_user)
    issuer='https://accounts.google.com'
    provider = Oidc::Provider.find_by!(issuer: issuer)
    id_token_string=request.headers['Authorization'].match(/Token token="(.*)"$/)[1]
    @@config ||= provider.config
    logger.warn("IdToken: #{id_token_string} #{@@config.jwks.inspect}")
    id_token = OpenIDConnect::ResponseObject::IdToken.decode id_token_string, @@config.jwks
    #verify
    valid=id_token.aud==provider.identifier &&
          id_token.iss==provider.issuer &&
          id_token.sub.present? &&
          Time.at(id_token.iat) > 24.hours.ago # we don't use exp as google only issues 1h idToken

    @current_user = provider.user(id_token)
  end
end
