StreamGrabber
=============

StreamGrabber is a way of multiplexing streams and feeds together into a timeline, it supports twitter, last.fm and github at the moment but is designed to be fairly trivial to add new sources, providing they have some kind of public facing data stream…

Usage
-----
At the moment StreamGrabber supports Twitter, last.fm and Github so
you'll need to give it your username for these sites. Create
`#{RAILS_ROOT}/config/stream_grabber.yml` so that it looks like the
following

    :twitter: username
    :lastfm: username
    :github: username

And then you can include the plugin in your Gemfile like so

    gem 'stream_grabber'

and load the helper method in your chosen controller.

    class HomepageController < ApplicationController
      helper :stream_grabber

      # blah blah blah
    end

then in your views you use

    <%= generate_stream_list %>

to render an ordered list of your most recent activity, most recent
first. There are a couple of additional options you can pass to
customise the output, the first is the number of results you'd like back
(defaults to 15) and the second is the css id and class you wish to be 
applied to the output. You can use these as follows

    <%= generate_stream_list 5, :class => 'foo' , :id => 'bar' %>

Adding new Sources
------------------

Sources are defined as classes in the StreamGrabber module, they are all
loaded dynamically so all your new source has to do is conform to the
following interface

    module StreamGrabber
      class Twitter
        def initialize(user_name)
          # do your setup in here to grab and parse the stream
        end

        def last_five
          # returns your data as a timestamp keyed hash
        end
      end
    end

And as long as `last_five` returns a hash with timestamps as keys, then
whatever is in the hash values will be squirted into the `li` elements
in the resulting list.

Over engineered? Damn Straight!!

If you want to add sources, please give me a pull request and I'll merge
them straight in.
