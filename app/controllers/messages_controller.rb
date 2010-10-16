class MessagesController < ApplicationController
  def index
    
  end
  
  def create
    Pusher[params[:auditorium_id]].trigger('chatroom', { :text => params[:message][:text] })
    render :nothing => true
  end
end
