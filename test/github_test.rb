require File.join(File.dirname(__FILE__), *%w[test_helper])

class GithubUnitTests < Test::Unit::TestCase
  context "A new Github Grabber" do
    setup do
      @github = StreamGrabber::Github.new('username')
    end

    should "return 5 items of recent activity" do
      assert_equal 5, @github.last_five.count
    end

    should "return the most recent items as a hash" do
      assert_equal Hash, @github.last_five.class
      assert_equal most_recent_timestamps, @github.last_five.sorted
    end
  end

  def most_recent_timestamps
    [Time.parse("2010-10-17T08:17:17-07:00").to_i,
     Time.parse("2010-10-17T08:15:48-07:00").to_i,
     Time.parse("2010-10-17T08:15:36-07:00").to_i,
     Time.parse("2010-10-14T08:10:06-07:00").to_i,
     Time.parse("2010-10-05T14:48:18-07:00").to_i ]
  end
end
