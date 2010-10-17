namespace :importers do
  desc "Movies from archive.org"
  task :archive_org_movies => :environment do
    require 'open-uri' 

    file = File.open "#{::Rails.root.to_s}/data/archive_movies.json"
    data = JSON.parse file.read
    file.close
    seed_data = [] # this is what we'll end up importing with seed.rb
    imdb = ImdbParty::Imdb.new # create an interface to imdb for later

    data["response"]["docs"].each do |movie|
      # "description" -> really long
      # "title":"Sex Madness",
      # "licenseurl":"http://creativecommons.org/licenses/publicdomain/",
      # "avg_rating":1.8,
      # "identifier":"sex_madness",
      # "subject":[ "exploitation", "melodrama"],
      #"format":[ "512Kb MPEG4", "Animated GIF", "MPEG2", "Metadata", "Ogg Video", "Thumbnail", "XML Metadata"], 
      # "collection":[ "feature_films", "moviesandfilms"]},

      download_base = "http://www.archive.org/download"

      # make sure we have a video format we can work with
      if movie["format"] and movie["format"].include? "Ogg Video" and movie["format"].include? "512Kb MPEG4"

        # make sure we have a title and identifier
        if movie["identifier"] and movie["title"] 
          oggs = []
          mp4s = []
          thumbnail = nil

          identifier = movie["identifier"]
          #puts movie["identifier"]
          #puts movie["title"]
          #puts "#{download_base}/#{identifier}/#{identifier}_files.xml"

          doc = Hpricot( open("#{download_base}/#{identifier}/#{identifier}_files.xml"))
          (doc/"file").each do |f|

            if (f/"format").inner_html == '512Kb MPEG4'
              mp4s << f.get_attribute('name')
            elsif (f/"format").inner_html == 'Ogg Video'
              oggs << f.get_attribute('name')
            elsif (f/"format").inner_html == 'Thumbnail'
              # set it if this is the first thumbnail we see
              thumbnail = f.get_attribute('name') if thumbnail.nil?

              # use the 60-sec one if we get it
              if f.get_attribute('name') =~ /.*_000060.jpg$/
                thumbnail = f.get_attribute('name')
              end
            end

          end

          # only work with movies that have one file for the whole movie
          if mp4s.size == 1 and oggs.size == 1
            puts movie["title"]

            seed = {
              :title => movie["title"],
              :mp4 => "#{download_base}/#{identifier}/#{mp4s.first}",
              :ogg => "#{download_base}/#{identifier}/#{oggs.first}",
              :permalink => movie["title"].parameterize,
              :thumbnail => "#{download_base}/#{identifier}/#{thumbnail}",
              :description =>  movie["description"],
              :external_rating => movie["avg_rating"] ? (movie["avg_rating"].to_f * 20).to_i : nil,
            }
             
            almost_imdb_movie = imdb.find_by_title(movie["title"]).first
            imdb_movie = nil 
            if almost_imdb_movie
              require 'pp'
              pp  almost_imdb_movie[:imdb_id]
              imdb_movie = imdb.find_movie_by_id(almost_imdb_movie[:imdb_id]) if almost_imdb_movie[:imdb_id]
            end

            unless imdb_movie.nil?
              x = { 
                :poster => imdb_movie.poster_url,
                :tagline => imdb_movie.tagline,
                :certification => imdb_movie.certification,  # supposed to be pg-13, etc. we'll see
                :runtime => imdb_movie.runtime,
                :released_on => Chronic.parse(imdb_movie.release_date), 
                :imdb_rating => imdb_movie.rating ? (imdb_movie.rating.to_f * 10).to_i : nil,
                :imdb_id => imdb_movie.imdb_id
                # do something with genres.  need model for that.  FIXME
              }

              seed.merge! x
            end 

            seed_data << seed
          end
        end 
      end
    end
    
    outfile = File.open("#{::Rails.root.to_s}/data/archive_movies_seed.json",'w+')
    outfile << seed_data.to_json 
    outfile.close
  end
  # end

  desc "Amusing facts from imdb.  This relies on the vidoes being in the db."
  task :imdb_facts => :environment do
    #require 'open-uri' 

    Video.all.each do |movie|
      # 
    end
  end
end
