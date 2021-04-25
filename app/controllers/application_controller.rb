class ApplicationController < ActionController::API
  include Fxnet::Graphiti::Controller
  before_action :current_user

  def current_user
    return @current_user if defined?(@current_user)
    issuer='https://accounts.google.com'
    expected_audience='240264605235-bfdi1vvgnq75a4ds1msqdf08ctesv54p.apps.googleusercontent.com'

    id_token_string=request.headers['Authorization'].match(/Token token="(.*)"$/)[1]
    @@config ||= OpenIDConnect::Discovery::Provider::Config.discover!(issuer)
    logger.warn("IdToken: #{id_token_string} #{@@config.jwks.inspect}")
    jwk_set=JSON::JWK::Set.new(@@config.jwks)
    id_token = JSON::JWT.decode(id_token_string, jwk_set)
    #verify
    valid=id_token[:aud]==expected_audience &&
          id_token[:iss]==issuer &&
          id_token[:sub].present? &&
          Time.at(id_token[:iat]) > 24.hours.ago # we don't use exp as google only issues 1h idToken

    raise("IdToken not valid") unless valid

  end
end
