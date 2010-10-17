class AuditoriumController < ApplicationController
  before_filter :user_management, :only => :show
  before_filter :find_video, :only => [:show, :create]
  before_filter :find_screen, :only => :show
  before_filter :find_messages, :only => :show
  
  def index
    @videos = Video.where(:featured => true).order("imdb_rating + external_rating DESC").limit(8)
  end

  def search
    @search = Video.search do
      keywords(params[:q])
    end
  end
  
  def show
    unless @screen
      @screens = @video.screens
      render :list
    end
  end
  
  def create
    screen = Screen.create :video_id => @video.id
    redirect_to auditorium_screen_path(@video.permalink, :screen => screen.uuid)
  end
  
private
  def find_video
    @video = Video.where(:permalink => (params[:id] || params[:auditorium_id])).first
    redirect_to auditorium_index_path unless @video
  end
  
  def find_screen
    return unless @video
    @screen = @video.screens.where(:uuid => params[:screen]).first
  end
  
  def find_messages
    return unless @screen
    @messages = @screen.messages.limit(10).order('id DESC')
  end
end
