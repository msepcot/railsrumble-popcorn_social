class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def user_management
    unless cookies[:movie_ticket] || user_agent_is_bot?
      @current_user = User.create :display_name => 'guest'
      cookies[:movie_ticket] = { :value => @current_user.uuid, :expires => 2.weeks.from_now }
    end
  end
  
  helper_method :current_user
  def current_user
    return @current_user if defined? @current_user
    @current_user = User.where(:uuid => cookies[:movie_ticket]).first
  end
  
  helper_method :user_agent_is_bot?
  def user_agent_is_bot?
    request.env['HTTP_USER_AGENT'] =~ /(AdsBot-Google|Apache-HttpClient|Apple-PubSub|AppleSyndication|Ask Jeeves|BaiduImagespider|Baiduspider|BoardPulse|BoardReader|CCBot|COMODOspider|Commons-HttpClient|ESigil Request 1.0|FeedBurner|Gaisbot|Gigabot|GomezAgent|Googlebot|Java\/1.|Keybot Translation-Search-Machine|LinkedInBot|MLBot|MSR-ISRCCrawler|MediaPartners-Google|Nixxie|OpenISearch|OpenNMS|OpenplacesBot|PostRank|PycURL|Python-urllib|R6_FeedFetcher|ScoutJet|ShareThisFetcher|SockrollBot|Sogou web spider|Sosospider|TinEye|Twiceler|UniversalFeedParser|VSynCrawler|ValueClick LM ClickSense|Wget|Windows-RSS-Platform|Yahoo! Slurp|YahooYSMcm|Yammer Feed Eater|Yanga Worldsearch|adidxbot|atraxbot|aypbot|check_http|facebookexternalhit|facebookplatform|ia_archiver|magpie-crawler|msnbot|niXXieBot|psbot|rssreader@newstin.com)/i
  end
end
