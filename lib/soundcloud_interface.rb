module SoundcloudInterface

  @@main_client = Soundcloud.new(client_id: ENV['SOUNDCLOUD_CLIENT_ID'], client_secret: ENV['SOUNDCLOUD_CLIENT_SECRET'], redirect_uri: ENV['SOUNDCLOUD_REDIRECT_URL'])

  @@user_client = nil

  def self.set_client access_token
    @@user_client = Soundcloud.new(access_token: access_token)
  end

  def self.get_token access_code
    @@main_client.exchange_token(code: access_code)
  end

  def self.authorize_url 
    @@main_client.authorize_url(scope: 'non-expiring')
  end

  def self.get_user
    @@user_client.get('/me')
  end

end
