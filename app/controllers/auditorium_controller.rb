class AuditoriumController < ApplicationController
  def index
    @video = OEmbed::Providers.get('http://www.hulu.com/watch/169366/black-sheep')
  end
end
