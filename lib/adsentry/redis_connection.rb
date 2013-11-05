require 'redis'

$REDIS ||= Redis.new(:adsentry, driver: :hiredis)