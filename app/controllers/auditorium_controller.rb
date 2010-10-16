class AuditoriumController < ApplicationController
  def index
    @videos = Video.limit(10)
  end
  
  def show
    # @video = OEmbed::Providers.get('http://www.hulu.com/watch/169366/black-sheep')
    @video = Video.where(:permalink => params[:id]).first
    @messages = []
  end
end

# attributes: 
#   permalink: night-of-the-living-dead
#   created_at: 2010-10-16 15:23:22.230714
#   updated_at: 2010-10-16 15:23:22.230714
#   ogg: http://www.archive.org/download/night_of_the_living_dead/night_of_the_living_dead.ogv
#   id: 1
#   mp4: http://www.archive.org/download/night_of_the_living_dead/night_of_the_living_dead_512kb.mp4
#   height: 480
#   width: 640
