class Adsentry::Annalist

  def initialize(queue)
    @queue = queue
  end

  def insert(ad_id)
    $REDIS.rpush(queue, ad_id.to_s)
  end

  def processing_count
    $REDIS.llen(queue)
  end

  def complete(ad_id)
    $REDIS.lrem(queue, 0, ad_id.to_s)
  end

  private

  attr_reader :queue

end