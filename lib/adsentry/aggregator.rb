class Adsentry::Aggregator

  AD_QUEUES_KEY = 'ad_queues'

  def self.register(queue_name)
    $ADSENTRY_REDIS.sadd(AD_QUEUES_KEY, queue_name)
  end

  def self.recite
    $ADSENTRY_REDIS.smembers(AD_QUEUES_KEY)
  end

  def self.report
    report = []
    $ADSENTRY_REDIS.smembers(AD_QUEUES_KEY).each do |ad_queue|
      annalist = Adsentry::Annalist.new(ad_queue)
      report << {name: ad_queue, count: annalist.processing_count, members: annalist.members}
    end
    report
  end

end
