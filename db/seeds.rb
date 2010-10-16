# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

file = File.open "#{::Rails.root.to_s}/data/archive_movies_seed.json"
archive_movies = JSON.parse file.read
file.close

archive_movies.each do |movie|
  Video.create movie
end
Video.all.each {|v| v.update_attributes :width => 640, :height => 480 }
