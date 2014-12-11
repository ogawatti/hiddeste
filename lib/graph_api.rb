module GraphAPI
  ENDPOINT = "https://graph.facebook.com"

  extend self

  def version(access_token)
    response = get(access_token)
    response.headers["facebook-api-version"]
  end

  def me(access_token)
    FbGraph::User.me(access_token).fetch
  end

  def feed(access_token, options={})
    me = FbGraph::User.me(access_token)
    me.feed!(link: options[:link])
  end

  def delete_permissions(access_token)
    me = FbGraph::User.me(access_token)
    me.revoke!
  end

  private

  def get(access_token, path="/me")
    connection = Faraday::Connection.new(:url => ENDPOINT)
    query = "access_token=#{access_token}"
    response = connection.get(path + "?" + query)
  end
end
