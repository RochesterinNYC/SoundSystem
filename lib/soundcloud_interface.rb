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
  def self.get_shuffle_playlist_id user, playlists
    @playlists = Hash.new
    playlists.each do |playlist|
      @playlists[playlist.title] = playlist.id;
    end
    shuffle_playlist_id = @playlists["#{user.full_name}'s Shuffle"]
    shuffle_playlist_id
  end

  #Generic method for getting a certain playlist attribute
  #Playlist is matched by a specified identifier that will match identifier_match
  #Example, can return the playlist uri of a playlist named "James Wen's Shuffle"
  def self.get_attribute_from_playlist playlists, identifier_name, identifier_match, attribute_name
    playlist_attribute = nil
    playlists.each do |playlist|
      if playlist[identifier_name] == identifier_match
        playlist_attribute = playlist[attribute_name]
      end
    end
    return playlist_attribute
  end

  def self.create_playlist_shuffle playlist_id, user
    # get all playlists for user
    @playlists = get_playlists

    # find songs from specific playlist that user wants to shuffle
    playlist_title = get_attribute_from_playlist(@playlists, "id", playlist_id.to_i, "title")
    @playlist_songs = get_attribute_from_playlist(@playlists, "id", playlist_id.to_i, "tracks")
    @playlist_song_ids = @playlist_songs.collect{|song| song.id}

    # randomize playlist
    @songs = get_playlist_shuffle(playlist_id, @playlist_song_ids)
    @songs = @songs.map { |id| {id: id} }

    #Cut down on amount of data we're working with
    @playlists = @playlists.map{ |playlist| {"id" => playlist.id, "title" => playlist.title, "uri" => playlist.uri} }

    #Get playlist id of shuffle playlist or nil if it doesn't exist
    shuffle_id = get_attribute_from_playlist(@playlists, "title", "#{user.full_name}'s Shuffle", "id")

    # either create new shuffle playlist or update existing one
    if shuffle_id.nil?
      playlist = @@user_client.post('/playlists', :playlist => {
        :title => "#{user.full_name}'s Shuffle",
        :sharing => 'public',
        :tracks => @songs,
        :description => "Shuffle for playlist: #{playlist_title}" 
      })
      shuffle_id = playlist.id
    else
      # find shuffle playlist uri
      uri = get_attribute_from_playlist(@playlists, "id", shuffle_id, "uri")
      @@user_client.put(uri, :playlist => {
        :tracks => @songs,
        :description => "Shuffle for playlist: #{playlist_title}"
      })
    end
    shuffle_id
  end

  def self.get_playlist_shuffle playlist_id, track_ids
    length = track_ids.length
    random = Random.new
    track_ids.each_with_index do |song, index| 
      rand_index = random.rand(0..length - 1)
      track_ids[index], track_ids[rand_index] = track_ids[rand_index], track_ids[index]
    end
    track_ids
  end

end
