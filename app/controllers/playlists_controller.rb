class PlaylistsController < ApplicationController
  
  def index
    @playlists = current_user.get_playlists
  end

  def shuffle 
    @songs = current_user.get_shuffle params[:id]
  end

end
