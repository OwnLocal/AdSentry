class Adsentry::Alerter

  def self.record(list_name)
    $REDIS.lpush("adsentry:#{list_name}", Time.now.to_f)
  end

  def self.since_last_event(list_name)

  end

end