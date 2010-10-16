class AuditoriumController < ApplicationController
  def index
    @video = OEmbed::Providers.get('http://www.hulu.com/watch/169366/black-sheep')
    # Pusher['black-sheep'].trigger('chatroom',{:text => 'pusher!'})
  end
end
