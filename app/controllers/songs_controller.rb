class SongsController < ApplicationController

  def index
     if params[:artist_id]
        @artist = Artist.find_by_id(params[:artist_id])
        if @artist
          @artist.songs
        else
          @songs = Song.all
          redirect_to artists_path
        end
     end
  end

  def show
    if Song.find(params[:id])
    else
      flash[:alert] = "Artist song not found"
    redirect_to artist_songs_path(@artist)
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

