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

  #If shuffle playlist does not exist, return nil
  def self.get_shuffle_playlist_id user
    @playlists = Hash.new
    @@user_client.get('/me/playlists').each do |playlist|
      @playlists[playlist.title] = playlist.id;
    end
    shuffle_playlist_id = @playlists["#{user.full_name}'s Shuffle"]
    shuffle_playlist_id
  end
  
  def self.create_playlist_shuffle playlist_id, user
    @songs = get_playlist_shuffle(playlist_id).collect{|song| song.id}
    @songs = @songs.map { |id| {:id => id} }
    shuffle_playlist_id = get_shuffle_playlist_id user
    if shuffle_playlist_id.nil?
      playlist = @@user_client.post('/playlists', :playlist => {
        :title => "#{user.full_name}'s Shuffle",
        :sharing => 'public',
        :tracks => @songs
      })
    else
      playlist = @@user_client.get("/playlists/#{shuffle_playlist_id}")
      @@user_client.put(playlist.uri, :playlist => {
        :tracks => @songs
      })
    end
    playlist.id
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
