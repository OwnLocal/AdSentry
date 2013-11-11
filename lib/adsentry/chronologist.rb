class Adsentry::Chronologist

  def self.record(key, value)
    $ADSENTRY_REDIS.zadd(key, Time.now.to_f, value)
  end

  def self.since_last_event(key)
    last_member = $ADSENTRY_REDIS.zrange(key, 0, 1, {withscores: true})
    return 0 unless last_member.first
    last_score = last_member.first.last
    Time.now.to_f - last_score.to_f
  end

  def self.last_times(key, set_size = 1000)
    last_scores_and_times = $ADSENTRY_REDIS.zrange(key, 0, set_size, {withscores: true})
    last_scores_and_times.map(&:last).map(&:to_f)
  end

  def self.since_time(key, time)
    last_scores_and_times = $ADSENTRY_REDIS.zrangebyscore(key, time.to_f, '+inf', {withscores: true})
    last_scores_and_times.map(&:last).map(&:to_f)
  end

end