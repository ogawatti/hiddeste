module TwitterAPI
  extend self

  def tweet(access_token, access_token_secret, options={})
    client(access_token, access_token_secret).update(options[:link])
  end

  def client(access_token, access_token_secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key        = Settings.twitter.api.key
      config.consumer_secret     = Settings.twitter.api.secret
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
  end
end
