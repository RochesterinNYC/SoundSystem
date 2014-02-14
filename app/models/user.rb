require 'soundcloud_interface'

class User < ActiveRecord::Base

  validates :soundcloud_id, presence: true, uniqueness: true
  validates :access_token, presence: true, uniqueness: true

  def self.find_or_create_by_token access_token
    ::SoundcloudInterface.set_client access_token
    user_info = ::SoundcloudInterface.get_user
    soundcloud_id = user_info['id']

    user = self.find_or_create_by(soundcloud_id: soundcloud_id)
    #if user.soundcloud_updated != user_info['updated_at']
    user.attributes = {
      access_token: access_token,
      username: user_info.username,
      permalink: user_info.permalink_url,
      avatar: user_info.avatar_url,
      full_name: user_info.full_name,
      city: user_info.city,
      description: user_info.description,
      website: user_info.website,
      track_count: user_info.track_count + user_info.private_tracks_count,
      playlist_count: user_info.playlist_count + user_info.private_playlists_count,
      favorites_count: user_info.public_favorites_count,
      followers_count: user_info.followers_count,
      followings_count: user_info.followings_count
    }
    user.save
    #end
    user
  end

  def get_playlists
    ::SoundcloudInterface.get_playlists
  end

  def initialize_client
    ::SoundcloudInterface.set_client access_token
  end

  def client_configured
    ::SoundcloudInterface.client_configured
  end

end