require 'json'
require 'open-uri'

module StreamGrabber
  class Twitter
    def initialize(user_name, api_key=nil)
      @user_name = user_name
      @doc = JSON.load(open("http://api.twitter.com/1/statuses/user_timeline.json?count=6&screen_name=#{user_name}"))
    end

    def last_five
      tweets = {}
      @doc.each do |tweet|
        date = Time.parse(tweet["created_at"]).to_i
        tweets[date] = [:twitter, message_from(tweet["text"], tweet["id"])]
      end
      tweets
    end

    def message_from(text, id)
      %Q{<a href="http://twitter.com/#{@user_name}/status/#{id}">#{text}</a>}
    end

  end
end
