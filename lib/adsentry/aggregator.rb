class Adsentry::Aggregator

  AD_QUEUES_KEY = 'adsentry:ad_queues'

  def self.register(queue_name)
    $REDIS.sadd(AD_QUEUES_KEY, queue_name)
  end

  def self.recite
    $REDIS.smembers(AD_QUEUES_KEY)
  end

  def self.report
    report = []
    $REDIS.smembers(AD_QUEUES_KEY).each do |ad_queue|
      annalist = Adsentry::Annalist.new(ad_queue)
      report << {name: ad_queue, count: annalist.processing_count}
    end
    report
  end

end
