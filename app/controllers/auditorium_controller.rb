class AuditoriumController < ApplicationController
  before_filter :user_management, :only => :show
  before_filter :find_video, :only => [:show, :create, :starts_in]
  before_filter :find_screen, :only => [:show, :starts_in]
  before_filter :find_messages, :only => :show
  
  def index
    @videos = Video.where(:featured => true).order("imdb_rating + external_rating DESC").limit(9)
  end

  def search
    @term = params[:q]
    @search = Video.search do
      keywords(params[:q])
    end
  end
  
  def show
    unless @screen
      @screens = @video.screens.public
      render :info
    end
  end
  
  def create
    screen = Screen.create(
      :video_id => @video.id, 
      :private => params[:screen][:private], 
      :start_time => (Time.now + params[:screen][:delay].to_i * 60)
    )
    redirect_to auditorium_screen_path(@video.permalink, :screen => screen.uuid)
  end

  def starts_in
    if @screen
      render :json => { :starts_in => (@screen.start_time - Time.now) }
    else
      render(:status => 404, :nothing => true)
    end
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
