class Adsentry::Aggregator

  AD_QUEUES_KEY = 'ad_queues'

  def self.register(queue_name)
    $REDIS.sadd(AD_QUEUES_KEY, queue_name)
  end

  def self.recite
    $REDIS.smembers(AD_QUEUES_KEY)
  end

  def self.report
    report = {}
    $REDIS.smembers(AD_QUEUES_KEY).each do |ad_queue|
      report[ad_queue] = Adsentry::Annalist.new(ad_queue).processing_count
    end
    report
  end

end
