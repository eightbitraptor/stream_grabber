require "rubygems"
require "rake/gempackagetask"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => [:test]

spec = Gem::Specification.new do |s|
  s.name              = "stream_grabber"
  s.version           = "0.1.0"
  s.summary           = "Yo dawg! I heard you like feeds so I multiplexed them"
  s.author            = "Matt House"
  s.email             = "matt@eightbitraptor.com"
  s.homepage          = "http://eightbitraptor.com"

  s.has_rdoc          = false
  s.files             = %w(README.md Rakefile) + Dir.glob("lib/**/*") + Dir.glob("test/**/*")
  s.require_paths     = ["lib"]

  s.add_dependency("nokogiri", "~> 1.4.0")
  s.add_dependency("simple-rss", "~> 1.2.0")
  s.add_development_dependency("fakeweb", "~> 1.2.0")
  s.add_development_dependency("shoulda", "~> 2.11.0")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
