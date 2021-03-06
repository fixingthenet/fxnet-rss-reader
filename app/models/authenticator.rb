class Authenticator
  include ActiveModel::Validations

  EXPECTED={
    issuer: ENV["EXPECTED_ISSUER"],
    audience: ENV["EXPECTED_AUDIENCE"],
    scope: ENV["EXPECTED_SCOPE"]
  }

  def self.parse(auth)
    if auth && match=auth.match(/Bearer (.*)/)
      new(token: match[1])
    else
      new(token: nil)
    end
  end

  validate :extract

  attr_reader :token, :sub, :scopes
  def initialize(token:)
    @token=token
  end

  def guest?
    @token.nil?
  end

  def expires_at
    Time.at(@expires_at)
  end

  private

  def expected
    EXPECTED
  end

  def extract
    return
    
    payload, info=JSON::JWT.decode token, :skip_verification
    config = ::OpenIDConnect::Discovery::Provider::Config.discover!(payload["iss"]) # cache this!
    public_key=config.jwks
    logger.debug [token,payload,info,config.inspect, public_key]
    decoded=::OpenIDConnect::ResponseObject::IdToken.decode(token, public_key)
    logger.debug [payload,info,config.inspect, public_key, decoded]

    errors.add("exp","expired") unless decoded.exp.to_i > Time.now.to_i
    errors.add("iss","wrong issuer") unless expected[:issuer]==decoded.iss
    #errors.add("nonce") ,expected[:nonce]==decoded.nonce
    errors.add("aud","wrong audience") unless Array(decoded.aud).include?(expected[:audience])
    errors.add("scopes","wrong scopes") unless Array(payload['scopes']).include?(expected[:scope])
    #begin
    #  decoded.verify!(expected.merge(nonce: decoded.nonce)) # nonce doesn't make sense
    #rescue
     # errors.add(:base, "verification failed!")
    #  logger.warn(["INVALID Token",$!])
    #end
    logger.error(errors.inspect)
    @sub=decoded.sub
    @scopes=payload["scopes"]
    @expires_at=payload["exp"]
  end

  def logger
    Rails.logger
  end
end
