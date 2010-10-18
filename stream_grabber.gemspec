Gem::Specification.new do |s|
  s.name              = "stream_grabber"
  s.version           = "0.1.0"
  s.summary           = "Yo dawg! I heard you like feeds so I multiplexed them"
  s.author            = "Matt House"
  s.email             = "matt@eightbitraptor.com"
  s.homepage          = "http://eightbitraptor.com"

  s.has_rdoc          = false
  s.files             = %w(README.md Rakefile) + Dir["lib/**/*"] + Dir["test/**/*"] + Dir["rails/**/*"] + Dir["app/**/*"]
  s.require_paths     = ["lib"]

  s.add_dependency("nokogiri", "~> 1.4.0")
  s.add_dependency("simple-rss", "~> 1.2.0")
  s.add_development_dependency("fakeweb", "~> 1.2.0")
  s.add_development_dependency("shoulda", "~> 2.11.0")
end
