class Adsentry::Alerter

  def self.record(list_name)
    $REDIS.lpush(key_for_list_name(list_name), Time.now.to_f)
  end

  def self.since_last_event(list_name)
    Time.now.to_f - $REDIS.lindex(key_for_list_name(list_name), 0).to_f
  end

  def self.last_members(list_name, set_size = 1000)
    $REDIS.lrange(key_for_list_name(list_name), 0, set_size).map(&:to_f)
  end

  private

  def self.key_for_list_name(list_name)
    list_name.to_s.start_with?('adsentry:') ? "#{list_name}:timeseries" : "adsentry:#{list_name}:timeseries"
  end

end