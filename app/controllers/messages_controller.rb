class MessagesController < ApplicationController
  before_filter :find_video
  before_filter :find_screen, :only => :create
  
  def index
    render :json => @video ? @video.notes.map(&:text) : []
  end
  
  def create
    if current_user
      current_user.messages.create :text => params[:message][:text], :screen_id => @screen.id
      unless current_user.display_name == params[:display_name] || params[:display_name].blank?
        current_user.update_attribute(:display_name, params[:display_name])
      end
    end
    Pusher["#{@video.permalink}-#{@screen.uuid}"].trigger(
      'chatroom', { :text => params[:message][:text], :user => current_user.try(:display_name) || params[:display_name] }
    )
    render :nothing => true
  end
private
  def find_video
    @video = Video.where(:permalink => params[:auditorium_id]).first
  end
  
  def find_screen
    @screen = @video.screens.where(:uuid => params[:screen]).first
  end
end
