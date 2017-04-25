require 'test_helper'

class SensorsAnalyticsTest < Minitest::Test
  TEST_URL = 'http://sa_host.com:8006/sa?token=xxx'

  def setup
    consumer = SensorsAnalytics::DefaultConsumer.new(TEST_URL)
    @sa = SensorsAnalytics::SensorsAnalytics.new(consumer)
  end

  def test_that_it_has_a_version_number
    refute_nil ::SensorsAnalytics::VERSION
  end

  def test_track
    SensorsAnalytics::Http.any_instance.expects(:request).returns([200, "ok"])

    @sa.track("abcdefg", "test_event",
      "age" => 26,
      "$time" => Time.now,
      "event_time" => Time.now)
  end

  def test_profile_set
    SensorsAnalytics::Http.any_instance.expects(:request).returns([200, "ok"])

    @sa.profile_set("abcdefg", {age: 24, sex: "male"})
  end
end
