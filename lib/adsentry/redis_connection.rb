require 'redis'
require 'hiredis'
require 'redis-namespace'

$REDIS ||= Redis.new(driver: :hiredis)
$ADSENTRY_REDIS = Redis::Namespace.new(:adsentry, redis: $REDIS)