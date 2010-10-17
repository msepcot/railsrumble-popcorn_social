# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#movies = File.open "#{::Rails.root.to_s}/data/archive_movies_seed.json"
#archive_movies = JSON.parse movies.read
#movies.close

#archive_movies.each do |movie|
#  Video.create movie
#end
#Video.all.each {|v| v.update_attributes :width => 640, :height => 480 }

goofs = JSON.parse(File.open("#{::Rails.root.to_s}/data/imdb_goofs_seed.json").read)
goofs.each_pair do |k,v|
  unless v.empty?
    puts k

    video = Video.find_by_imdb_id k

    v.each do |n|
      note = Note.new
      note.text = n.gsub(/\n/,'')
      note.video = video
      note.source = 'imdb'
      note.save
    end
  end
end 

