class PlaylistsController < ApplicationController
  
  def index
    @playlists = current_user.get_playlists
  end

end