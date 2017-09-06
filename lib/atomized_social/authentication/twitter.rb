class AtomizedSocial::Authentication
  class Twitter
    def initialize(key, secret)
      @key = key
      @secret = secret
    end

    def authenticate(params)
      # Create the consumer for this request
      consumer = get_twitter_consumer

      # Get the request token for the request
      request_token = consumer.get_request_token(oauth_callback: params[:callback_url])

      # If the oauth_callback_confirmed is true, then we pass back the oauth tokens
      unless request_token[:oauth_callback_confirmed].nil? && request_token[:oauth_callback_confirmed]
        return { token: request_tokne[:oauth_token], token_secret: request_token[:oauth_token_secret] }
      else
        raise Atomized::Exceptions::BadCallbackError
      end
    end

    def retrieve_access_token(params)
      binding.pry
      # Create the consumer for this request
      consumer = get_twitter_consumer

      # Generate the request_token form hash
      request_token = OAuth::RequestToken.from_hash(consumer, {
        oauth_token: params[:token],
        oauth_token_secret: params[:token_secret]
      })

      # Request access tokens
      access_token = request_token.get_access_token

      # TODO: Pass back the request tokens
    end

    private

    def get_twitter_consumer
      OAuth::Consumer.new(@key, @secret, site: "https://api.twitter.com",
        authorize_path: '/oauth/authenticate')
    end
  end
end
