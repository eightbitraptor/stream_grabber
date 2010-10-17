require File.join(File.dirname(__FILE__), *%w[test_helper])

class LastFmUnitTests < Test::Unit::TestCase
  context "A new LastFM Grabber" do
    setup do
      @lastfm = StreamGrabber::LastFm.new('username')
    end

    should "return 5 items of recent activity" do
      assert_equal 5, @lastfm.last_five.count
    end

    should "return the most recent items as a hash" do
      most_recent_timestamps = [ 1287351412, 1287342471, 1287340078, 1285867525, 1285057821]
      assert_equal Hash, @lastfm.last_five.class
      assert_equal most_recent_timestamps, @lastfm.last_five.sorted
    end
  end
end
