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
    def set_config
      raw_config = File.read(Rails.root.to_s + "/config/stream_grabber.yml")
      @app_config ||= YAML.load(raw_config)
      @app_config
    end

    def mux_stream
      messages = {}
      StreamGrabber.constants.each do |klass|
        k = StreamGrabber.const_get(klass)
        if k.instance_of?(Class) and k.method_defined?('last_five')
          name = k.name.partition('::').last.underscore.downcase
          user_name = set_config[name.to_sym]["username"]
          api_key = set_config[name.to_sym]["api_key"]
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
