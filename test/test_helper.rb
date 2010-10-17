require 'fakeweb'
require 'open-uri'
require 'shoulda'

require File.join(File.dirname(__FILE__), *%w[.. lib stream_grabber])

class Hash
  def sorted
    self.keys.sort.reverse
  end
end

def twitter_response
  open_file("twitter.json")
end

def github_response
  open_file("github.atom")
end

def lastfm_response
  open_file("lastfm.xml")
end

def open_file(filename)
  File.read(File.join(File.dirname(__FILE__), "dummy_responses/#{filename}"))
end

FakeWeb.register_uri(:get, %r{http://api\.twitter\.com} , :body => twitter_response)
FakeWeb.register_uri(:get, %r{http://ws\.audioscrobbler\.com}, :body => lastfm_response)
FakeWeb.register_uri(:get, %r{https://github\.com/}, :body => github_response)
