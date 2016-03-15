require './sensors_analytics.rb'

DISTINCT_ID = 'abcdefg'

SA_URL = 'http://sa_host.com:8006/sa?token=xxx'

def debug_mode_demo
  begin
    SensorsAnalytics::DebugConsumer.new(SA_URL, false)
  rescue => e
    puts "Expected excaption: '#{e.message}'"
  end

  consumer = SensorsAnalytics::DebugConsumer.new(SA_URL, false)
  sa = SensorsAnalytics::SensorsAnalytics.new(consumer)
  
  begin
    properties = {
        "sex" => "male",
        "age" => 123,
        "$time" => Time.now(),
        "event_time" => Time.now()
    }
    # expects 'valid message...'
    sa.track(DISTINCT_ID, "RubyDemoStart", properties)
  rescue => e
    puts "Unexpected exception: '#{e.message}'"
  end
 
  consumer = SensorsAnalytics::DebugConsumer.new(SA_URL, true)
  sa = SensorsAnalytics::SensorsAnalytics.new(consumer)
  
  begin
    properties = {
        "sex" => "male",
        "age" => 123
    }
    # expects 'valid message...'
    sa.track(DISTINCT_ID, "RubyDemoStart", properties)
  rescue => e
    puts "Unexpected exception: '#{e.message}'"
  end

  begin
    properties = {
        "age" => "123"
    }
    # expects 'invalid message...'
    sa.track(DISTINCT_ID, "RubyDemoStart", properties)
  rescue => e
    puts "Expected exception: '#{e.message}'"
  end

  begin
    sa.profile_set(DISTINCT_ID, {"sex" => "male", "age" => 123})
    sa.profile_increment(DISTINCT_ID, {"age" => 10})
    sa.profile_set_once(DISTINCT_ID, {"sex" => "female"})
    sa.profile_append(DISTINCT_ID, {"songs" => ["aaa", "bbb"]})
    sa.profile_unset(DISTINCT_ID, ["songs", "sex"])
  rescue => e
    puts "Unexpected exception: '#{e.message}'"
  end

end

def default_consumer_demo
  consumer = SensorsAnalytics::DefaultConsumer.new(SA_URL)
  sa = SensorsAnalytics::SensorsAnalytics.new(consumer)

  begin
    sa.track(DISTINCT_ID, "RubyDemoStart", {"sex" => "male", "age" => 123})
  rescue => e
    puts "Unexpected exception: '#{e.message}'"
  end

  begin
    sa.track("", "RubyDemoStart")
  rescue => e
    puts "Expected exception: '#{e.message}'"
  end

  begin
    sa.track(DISTINCT_ID, "event")
  rescue => e
    puts "Expected exception: '#{e.message}'"
  end

  begin
    sa.track(DISTINCT_ID, "RubyDemoStart", {"id" => "123"})
  rescue => e
    puts "Expected exception: '#{e.message}'"
  end

  consumer = SensorsAnalytics::DefaultConsumer.new("http://www.baidu.com")
  sa = SensorsAnalytics::SensorsAnalytics.new(consumer)

  begin
    sa.track(DISTINCT_ID, "RubyDemoStart")
  rescue => e
    puts "Expected exception: '#{e.message}'"
  end
end

def batch_consumer_demo
  consumer = SensorsAnalytics::BatchConsumer.new(SA_URL, 10)
  sa = SensorsAnalytics::SensorsAnalytics.new(consumer)

  begin
    for i in 0..15
      sa.track(DISTINCT_ID, "RubyDemoStart", {"sex" => "male", "age" => 123, "sort" => i})
    end
    # consumer 的 flush_bulk 设为10，因此 consumer 会批量发送10条 events，剩余5条，手动调用 consumer.flush() 发送
    consumer.flush()
  rescue => e
    puts "Unexpected exception: '#{e.message}'"
  end
end

if __FILE__ == $0
  # Debug 模式
  debug_mode_demo()  
  # 普通模式
  default_consumer_demo()
  # 批量同步发送模式
  batch_consumer_demo()
end

