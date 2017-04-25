require 'test_helper'

class ConsumerTest < Minitest::Test
  def test_default_consumer
    refute_nil ::SensorsAnalytics::VERSION
  end
end
