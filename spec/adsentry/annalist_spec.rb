require 'spec_helper'

describe Adsentry::Annalist do
  it "can be initialized" do
    Adsentry::Annalist.new(:needs_work)
  end

  let(:it) {Adsentry::Annalist.new(:needs_work)}

  before(:each) do
    $REDIS.del(:needs_work)
    $REDIS.del(:needs_work_processing)
  end

  it "records an ad entering a queue" do
    it.insert(12345)
  end

  it "returns :empty_queue if you try to process on an empty queue" do
    it.process.should == :empty_queue
  end

  it "returns an id if you process on a queue with something in it" do
    it.insert(12345)
    it.process.should == "12345"
  end

  it "can count the number of things processing when empty" do
    it.processing_count.should == 0
  end

  it "adds the id of something popped to the processing list" do
    it.insert(12345)
    it.process
    it.processing_count.should == 1
  end

  it "can remove something from the processing list when it's completed" do
    it.insert(12345)
    it.process
    it.complete(12345).should == 1
    it.processing_count.should == 0
  end
end