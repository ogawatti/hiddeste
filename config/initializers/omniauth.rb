# Use GraphAPI v2.0
OmniAuth::Strategies::Facebook.option :client_options, {
  site:          'https://graph.facebook.com/v2.0',
  token_url:     '/oauth/access_token',
  authorize_url: 'https://www.facebook.com/v2.0/dialog/oauth'
}
