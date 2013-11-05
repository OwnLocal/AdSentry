class Adsentry::Chronologist

  def self.record(key, value)
    $ADSENTRY_REDIS.zadd(key, Time.now.to_f, value)
  end

  def self.since_last_event(key)
    last_score = $ADSENTRY_REDIS.zrange(key, 0, 1, {withscores: true}).first.last
    Time.now.to_f - last_score.to_f
  end

  def self.last_times(key, set_size = 1000)
    last_scores_and_times = $ADSENTRY_REDIS.zrange(key, 0, 1, {withscores: true})
    last_scores_and_times.map(&:last).map(&:to_f)
  end

end