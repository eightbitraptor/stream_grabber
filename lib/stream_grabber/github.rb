require 'simple-rss'
require 'open-uri'
require 'pp'

module StreamGrabber
  class Github
    def initialize(user_name)
      @doc = SimpleRSS.parse(open("https://github.com/#{user_name}.private.actor.atom?token=4ec7548d4e071bdc85462077a69bcdf2"))
    end

    def last_five
      commits = {}
      @doc.items.first(5).each do |item|
        date = Time.parse(item[:updated].to_s).to_i
        commits[date] = message_from(item[:link], item[:title])
      end
      commits
    end

    def message_from(link, title)
      %Q{<a href="#{link}">#{title}</a>}
    end
  end
end