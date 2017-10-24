require 'fluent/plugin/filter'
require 'redis'
require 'gcra/rate_limiter'
require 'gcra/redis_store'

module Fluent::Plugin
  class ThrottleFilter < Filter
    # Register this filter as "quota"
    Fluent::Plugin.register_filter('quota', self)

    config_param :rate_period, :float, default: 1.0
    config_param :max_burst, :integer, default: 1
    config_param :redis_url, :string, default: ""
    config_param :prefix, :string, default: "default"

    attr_accessor :redis

    def configure(conf)
      super
      # do the usual configuration here
    end

    def start
      super
      # This is the first method to be called when it starts running
      # Use it to allocate resources, etc.
      @cnt = 0
      @remaining = 1
      @redis = Redis.new(url: @redis_url)
      Thread.new {
      @store = GCRA::RedisStore.new(@redis, @prefix)

      @limiter = GCRA::RateLimiter.new(@store, @rate_period, @max_burst)
      }
    end

    def shutdown
      super
      @redis.close()
      # This method is called when Fluentd is shutting down.
      # Use it to free up resources, etc.
    end

    def filter(tag, time, record)
      # This method implements the filtering logic for individual filters
      # It is internal to this class and called by filter_stream unless
      # the user overrides filter_stream.
      #
      # If returns nil, that records are ignored.

      @cnt += 1
      if @cnt < @remaining
          return record
      end
      exceeded, info = @limiter.limit(@prefix, $cnt)
      @remaining = info.remaining
      if exceeded
          return nil
      end
      if $cnt > @remaining
          $cnt = 0
      end
      record
    end
  end
end
