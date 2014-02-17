class PlaylistsController < ApplicationController
  
  def index
    @playlists = current_user.get_playlists
  end

  def shuffle 
    @shuffle_id = current_user.create_shuffle params[:id], current_user
  end

end
