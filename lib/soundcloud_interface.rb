module SoundcloudInterface

  @@main_client = Soundcloud.new(client_id: ENV['SOUNDCLOUD_CLIENT_ID'], client_secret: ENV['SOUNDCLOUD_CLIENT_SECRET'], redirect_uri: ENV['SOUNDCLOUD_REDIRECT_URL'])

  @@user_client = nil

  def self.client_configured
    !@@user_client.blank?
  end

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

  def self.get_playlists
    @@user_client.get('/me/playlists')
  end

  def self.get_playlist_songs playlist_id
    @@user_client.get("/playlists/#{playlist_id}")
  end

  def self.get_playlist_shuffle playlist_id
    @songs = get_playlist_songs(playlist_id).tracks
    length = @songs.length
    random = Random.new
    @songs.each_with_index do |song, index| 
      rand_index = random.rand(0..length - 1)
      @songs[index], @songs[rand_index] = @songs[rand_index], @songs[index]
    end
    @songs
  end

end
