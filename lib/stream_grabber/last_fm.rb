require 'nokogiri'
require 'open-uri'

module StreamGrabber
  class LastFm
    def initialize(user_name, api_key)
      @user_name = user_name
      @doc ||= Nokogiri::XML(open("http://ws.audioscrobbler.com/2.0/?method=user.getlovedtracks&user=#{user_name}&api_key=#{api_key}"))
    end

    def last_five
      tracks = {}
      ff = @doc.xpath("//track").first(5)
      ff.each do |elem|
        date_loved = elem.>('date').first['uts'].to_i
        artist_name = elem.css('artist > name').text
        track_name = elem.>('name').text
        url = elem.>('url').text
        tracks[date_loved] = [:lastfm, message_for(artist_name,track_name, url)]
      end
      tracks
    end

    def message_for(artist, title, url)
      %Q{ <a href="#{url}">#{@user_name} loved the track #{title} by #{artist} on Last.fm</a>  }
    end
  end
end
