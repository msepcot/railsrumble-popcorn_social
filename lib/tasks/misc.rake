namespace :misc do
  desc 'cleanup duplicate permalinks'
  task :permalink => :environment do
    ActiveRecord::Base.connection.
    select_rows("SELECT permalink, COUNT(*) FROM videos GROUP BY permalink HAVING COUNT(*) > 1").
    each do |permalink, count|
      Video.where(:permalink => permalink).each_with_index do |video, index|
        video.update_attribute :permalink, "#{video.permalink}-#{index}" unless index.zero?
      end
    end
  end
  
  desc 'highlight horror movies'
  task :featured_movies => :environment do
    Video.where("permalink IN ('the-ghoul','night-of-the-living-dead','nosferatu','dr-jekyll-and-mr-hyde','teenagers-battle-the-thing','the-vampire-bat','terror-by-night','vengence-of-the-zombies')").each do |video|
      video.update_attribute :featured, true
    end
  end
  
  desc 'download posters'
  task :posters => :environment do
    require 'cgi'
    require 'net/http'
    require 'uri'
    
    count = Video.where('poster IS NOT NULL').count
    puts "Downloading IMDB Posters"
    Video.where('poster IS NOT NULL').each_with_index do |video, index|
      print "\r#{index + 1}/#{count}"
      STDOUT.flush
      
      location = URI.parse(video.poster)
      headers = { "User-Agent" => 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2) Gecko/20100130 Gentoo Firefox/3.6' }
      response = Net::HTTP::start(location.host, location.port) do |connection|
        connection.request_get("#{location.path}", headers)
      end
      raise response.inspect unless response.is_a?(Net::HTTPSuccess)
      File.open("#{Rails.root}/public/images/poster/#{video.permalink}#{File.extname(video.poster)}", "wb+") { |cache| cache.write(response.body) }
      sleep(2)
    end
  end
end