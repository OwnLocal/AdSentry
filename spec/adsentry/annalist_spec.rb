require 'spec_helper'

describe Adsentry::Annalist do
  it "can be initialized" do
    Adsentry::Annalist.new(:needs_work)
  end

  let(:it) {Adsentry::Annalist.new(:needs_work)}

  before(:each) do
    $ADSENTRY_REDIS.flushdb
  end

  it "records an ad entering a queue" do
    it.insert(12345)
  end

  it "can count the number of things processing when empty" do
    it.processing_count.should == 0
  end

  it "adds the id of something popped to the processing list" do
    it.insert(12345)
    it.processing_count.should == 1
  end

  it "can remove something from the processing list when it's completed" do
    it.insert(12345)
    it.complete(12345)
    it.processing_count.should == 0
  end

  it "records the time series of events in the chronologist" do
    it.insert(12345)
    Adsentry::Chronologist.since_last_event('needs_work:insertions').should < 1

    it.complete(12345)
    Adsentry::Chronologist.since_last_event('needs_work:completions').should < 1

  end
end