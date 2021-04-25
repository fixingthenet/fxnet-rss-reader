module Oidc
class Provider < ActiveRecord::Base

  serialize :scopes_supported, JSON

  has_many :open_ids, class_name: 'Oidc::OpenId'
#  belongs_to :user

  validates :issuer,                 presence: true, uniqueness: {allow_nil: true}
  validates :name,                   presence: true
  validates :identifier,             presence: {if: :registered?}
  validates :authorization_endpoint, presence: {if: :registered?}
  validates :token_endpoint,         presence: {if: :registered?}
  validates :userinfo_endpoint,      presence: {if: :registered?}

  scope :dynamic,  -> { where(dynamic: true) }
  scope :listable, -> { where(dynamic: false) }
  scope :valid, lambda {
    where(['expires_at is null or expires_at >= ?', Time.now.utc])
  }

  def self.manual_register(issuer:, identifier:, secret:, name:)
    p=new(issuer: issuer,
          identifier: identifier,
          secret: secret,
          name: name)
    config=p.config
    p.attributes = {
      scopes_supported:       config.scopes_supported,
      authorization_endpoint: config.authorization_endpoint,
      token_endpoint:         config.token_endpoint,
      userinfo_endpoint:      config.userinfo_endpoint,
      jwks_uri:               config.jwks_uri
    }
    p.save!
    p
  end

  def expired?
    expires_at.try(:past?)
  end

  def registered?
    identifier.present? && !expired?
  end

  def config
    @config ||= OpenIDConnect::Discovery::Provider::Config.discover! issuer
  end

  def register!(redirect_uri)
    client = OpenIDConnect::Client::Registrar.new(
      config.registration_endpoint,
      client_name: 'NOV RP',
      application_type: 'web',
      redirect_uris: [redirect_uri],
      subject_type: 'pairwise'
    ).register!
    self.attributes = {
      identifier:             client.identifier,
      secret:                 client.secret,
      scopes_supported:       config.scopes_supported,
      authorization_endpoint: config.authorization_endpoint,
      token_endpoint:         config.token_endpoint,
      userinfo_endpoint:      config.userinfo_endpoint,
      jwks_uri:               config.jwks_uri,
      expires_at:             client.expires_in.try(:from_now)
    }
    save!
  end

  def as_json(options = {})
    [
      :identifier, :secret, :scopes_supported, :host, :scheme, :jwks_uri,
      :authorization_endpoint, :token_endpoint, :userinfo_endpoint
    ].inject({}) do |hash, key|
      hash.merge!(
        key => self.send(key)
      )
    end
  end

  def client
    @client ||= OpenIDConnect::Client.new as_json
  end

  def client_auth_method
    supported = config.token_endpoint_auth_methods_supported
    if supported.present? && !supported.include?('client_secret_basic')
      :post
    else
      :basic
    end
  end

  # e.g.
  # provider.authorization_uri("https://rss-reader.dev.fixingthe.net/ep/oidc/callback","test")
  def authorization_uri(redirect_uri, nonce)
    client.redirect_uri = redirect_uri
    client.authorization_uri(
      response_type: :code,
      nonce: nonce,
      state: nonce,
      scope: scopes_supported & [:openid, :email, :profile, :address].collect(&:to_s),
    )
  end

  def decode_id(id_token)
    OpenIDConnect::ResponseObject::IdToken.decode id_token, config.jwks
  end

  def authenticate(redirect_uri, code, nonce)
    client.redirect_uri = redirect_uri
    client.authorization_code = code
    logger.info("access: #{redirect_uri}, #{code}")
    access_token = client.access_token! client_auth_method
    logger.info("idtoken: #{access_token.id_token}, #{issuer}, #{identifier}, #{nonce}")
    _id_token_ = decode_id access_token.id_token
    _id_token_.verify!(
      issuer: issuer,
      client_id: identifier,
      nonce: nonce
    )
    open_id = self.open_ids.find_or_initialize_by(identifier: _id_token_.subject)
    open_id.access_token, open_id.id_token = access_token.access_token, access_token.id_token
    open_id.user ||= User.create!(open_id: open_id)
    open_id.save!
    open_id.user
  end

  class << self
    def discover!(host)
      issuer = OpenIDConnect::Discovery::Provider.discover!(host).issuer
      if provider = find_by_issuer(issuer)
        provider
      else
        dynamic.create(
          issuer: issuer,
          name: host
        )
      end
    end
  end
end
end
#eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6ImRlZmF1bHQifQ.eyJpc3MiOiJodHRwczovL2F1dGguZGV2LmZpeGluZ3RoZS5uZXQiLCJzdWIiOiIxIiwiYXVkIjoiOTczMjQyYmQ2ZWMwNGUyNTA0NTgwYmQxY2NhNGE3Y2IiLCJleHAiOjE2MTc1NTk5MTMsImlhdCI6MTYxNzQ3MzUxMywibm9uY2UiOiJ0ZXN0In0.TZ-VosuvxYD7vBFpc9cyxnGkg0i4ft-Hc0L3zw6EcYeAq9uw_9PC1nI_LtgfTiCnXtxep_KDhgawYETiM-GrFlJhz2f_eH0Cij-XdIQf0NoBRTRwpY1208-RB37bZdHMq0_78JF4XZqPXtwSMvMt3p2vmuZqpA6TLEW5mRxw0YoiAGDZdgWnRkSi20dL7ai604LXVDbHwjgGGen9w9zd0f2m8eZ-afWlVT6BscGrXckfVkp0GRTmF2chNL3FTVWu1F3ZnDnezVO4bGkz7DittCSJP1dCnAShCTDoNw7VYiCESepQWU75vc2fafx44_oDS9K0K-1-fIY8n8VoF8ZHTQ
