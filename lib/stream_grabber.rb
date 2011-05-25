require 'stream_grabber/last_fm'
require 'stream_grabber/github'
require 'stream_grabber/twitter'
require 'rails'

if ENV['OFFLINE']
  # use test data if we are developing offline
  require File.expand_path(File.join(File.dirname(__FILE__), *%w[.. test test_helper.rb]))
end

module StreamGrabber

  class Engine < Rails::Engine; end

  class << self
      raw_config = File.read(Rails.root.to_s + "config/stream_grabber.yml")
      APP_CONFIG = YAML.load(raw_config)
    # now we should be able to do the following APP_CONFIG[:github][:username] APP_CONFIG[:github][:api_key]
   

    def mux_stream
      messages = {}
      StreamGrabber.constants.each do |klass|
        k = StreamGrabber.const_get(klass)
        if k.instance_of?(Class) and k.method_defined?('last_five')
          name = k.name.partition('::').last.underscore.downcase
          user_name = APP_CONFIG[name.to_sym][:username]
          api_key = APP_CONFIG[name.to_sym][:api_key]
          messages.merge!(k.new(user_name, api_key).send(:last_five))
        end
      end
      arr = messages.sort.reverse
    end

    def grab_all
      mux_stream
    end

    def grab(n)
      mux_stream.first(n)
    end
  end

end
