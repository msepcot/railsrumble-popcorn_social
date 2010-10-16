module AuditoriumHelper
  def video_js_tag(video)
    return unless video.mp4? || video.ogg?
    video_js = content_tag(:video, :id => video.permalink, :class => 'video-js', 
      :width => video.width, :height => video.height, :controls => 'controls', :preload => 'auto'
    ) do
      formats = []
      formats << content_tag(:source, nil, :src => video.mp4, :type => Video::MP4) if video.mp4?
      formats << content_tag(:source, nil, :src => video.ogg, :type => Video::Ogg) if video.ogg?
      
      flash = content_tag(:object, :class => 'vjs-flash-fallback', :width => video.width, :height => video.height, 
        :type => 'application/x-shockwave-flash', :data => 'http://releases.flowplayer.org/swf/flowplayer-3.2.1.swf'
      ) do
        content_tag(:param, nil, :name => 'movie', :value => 'http://releases.flowplayer.org/swf/flowplayer-3.2.1.swf') + 
        content_tag(:param, nil, :name => 'allowfullscreen', :value => 'false') + 
        content_tag(:param, nil, :name => 'flashvars', :value => "config={'playlist':[{'url': '#{video.mp4}','autoPlay':false,'autoBuffering':true}]}")
      end if video.mp4?
      
      formats.join.html_safe + flash
    end
    
    no_support = content_tag(:p, :class => 'vjs-no-video') do
      formats = []
      formats << content_tag(:a, 'MP4', :href => video.mp4) if video.mp4?
      formats << content_tag(:a, 'Ogg', :href => video.ogg) if video.ogg?
      
      content_tag(:strong, 'Download Video: ') + formats.join(', ').html_safe + 
      content_tag(:a, 'HTML5 Video Player', :href => 'http://videojs.com') + ' by VideoJS'
    end
    
    content_tag(:div, video_js + no_support, :class => 'video-js-box')
  end
end
