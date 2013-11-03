class Adsentry::Alerter

  def self.record(list_name)
    $REDIS.lpush("adsentry:#{list_name}", Time.now.to_f)
  end

  def self.since_last_event(list_name)
    Time.now.to_f - $REDIS.lindex("adsentry:#{list_name}", 0).to_f
  end

  def self.last_members(list_name, set_size = 1000)
    $REDIS.lrange("adsentry:#{list_name}", 0, set_size)
  end

end