class Adsentry::Annalist

  def initialize(queue)
    @queue = queue
  end

  def insert(ad_id)
    $REDIS.rpush(queue, ad_id)
  end

  def process
    return :empty_queue unless value = $REDIS.rpoplpush(queue, processing_queue)
    value
  end

  def processing_count
    $REDIS.llen(processing_queue)
  end

  def complete(ad_id)
    $REDIS.lrem(queue, 0, ad_id)
  end

  private

  attr_reader :queue

  def processing_queue
    "#{queue.to_s}_processing"
  end

end