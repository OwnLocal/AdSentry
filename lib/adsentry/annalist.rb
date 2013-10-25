class Adsentry::Annalist

  def initialize
    @queue = []
  end

  def insert(queue, ad_id)
    @queue << ad_id
  end

  def remove(queue, ad_id)
    return :not_in_queue unless @queue.include?(ad_id)
    return @queue.delete(ad_id)
  end

end