require File.join(File.dirname(__FILE__), *%w[test_helper])

class TwitterUnitTests < Test::Unit::TestCase
  context "A new Twitter Grabber" do
    setup do
      @twitter = StreamGrabber::Twitter.new('username')
    end

    should "return 5 items of recent activity" do
      assert_equal 5, @twitter.last_five.count
    end

    should "return the most recent items as a hash" do
      assert_equal Hash, @twitter.last_five.class
      assert_equal most_recent_timestamps, @twitter.last_five.sorted
    end
  end

  def most_recent_timestamps
    [Time.parse("Sun Oct 17 22:14:45 +0000 2010").to_i,
     Time.parse("Thu Oct 14 15:30:52 +0000 2010").to_i,
     Time.parse("Thu Oct 14 13:27:01 +0000 2010").to_i,
     Time.parse("Thu Oct 14 08:03:33 +0000 2010").to_i,
     Time.parse("Wed Oct 13 12:32:00 +0000 2010").to_i ]
  end
end
