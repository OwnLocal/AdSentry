class Adsentry::Annalist

  def initialize(queue)
    with_notification do
      @queue = queue.to_s.start_with?('adsentry:') ? queue : "adsentry:#{queue}"
      Adsentry::Aggregator.register(@queue)
    end
  end

  def insert(ad_id)
    with_notification do
      $REDIS.rpush(queue, ad_id.to_s)
    end
  end

  def processing_count
    with_notification do
      $REDIS.llen(queue)
    end
  end

  def complete(ad_id)
    with_notification do
      $REDIS.lrem(queue, 0, ad_id.to_s)
    end
  end

  private

  attr_reader :queue

  def with_notification(&block)
    begin
      yield
    rescue Redis::BaseError => e
      Raygun.track_exception(e)
    end
  end
end