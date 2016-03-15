# Sensors Analytics

This is the official Ruby SDK for Sensors Analytics.

## Easy Installation

You can get Sensors Analytics SDK using gem.

```
    gem install sensors_analytics_sdk
```

Once the SDK is successfully installed, use the Sensors Analytics SDK likes:

```
    require 'sensors_analytics_sdk.rb'

    SA_URL = 'http://sa_host.com:8006/sa?token=xxx'

    consumer = SensorsAnalytics::DefaultConsumer.new(SA_URL)
    sa = SensorsAnalytics::SensorsAnalytics.new(consumer)

    distinct_id = "ABCDEF123456"
    sa.track(distinct_id, "UserLogin", {"Source" : "HomePage"})
```

## To learn more

See our [full manual](http://www.sensorsdata.cn/manual/ruby_sdk.html)

