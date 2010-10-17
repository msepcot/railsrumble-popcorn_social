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
end