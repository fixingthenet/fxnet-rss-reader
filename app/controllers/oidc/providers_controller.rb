module Oidc
  class ProvidersController < ApplicationController
    def login
      url = provider.authorization_uri("https://rss-reader.dev.fixingthe.net/ep/oidc/callback",new_nonce)
      redirect_to url
    end

    def callback
      user = provider.authenticate(
        oidc_callback_url,
        params[:code],
        stored_nonce
      )
      render plain: "okok"
    end

    private
    def new_nonce
      "test"
    end
    def stored_nonce
      "test"
    end

    def provider
      @provider ||= Provider.find_by(name: 'google')
#      @provider ||= Provider.find_by(name: 'fxnet-auth')
    end
  end
end
