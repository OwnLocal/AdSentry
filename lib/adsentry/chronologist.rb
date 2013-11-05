class Adsentry::Chronologist

  def self.record(key, value)
    $REDIS.zadd(key, Time.now.to_f, value)
  end

  def self.since_last_event(key)
    last_score = $REDIS.zrange(key, 0, 1, {withscores: true}).first.last
    Time.now.to_f - last_score.to_f
  end

  def self.last_members(key, set_size = 1000)
    p last_scores_and_times = $REDIS.zrange(key, 0, set_size, {withscores: true})
    last_scores_and_times.map(&:last).map(&:to_f)
  end

end