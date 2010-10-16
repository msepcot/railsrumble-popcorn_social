class Video < ActiveRecord::Base
  Ogg = 'video/ogg; codecs="theora, vorbis"'
  MP4 = 'video/mp4; codecs="avc1.42E01E, mp4a.40.2"'
end
