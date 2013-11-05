require 'spec_helper'

describe Adsentry::Aggregator do

  before(:each) do
    $ADSENTRY_REDIS.flushdb
  end

  it "registers a queue with itself" do
    Adsentry::Aggregator.register("some_queue")
  end

  it "recites the queues as a list" do
    Adsentry::Aggregator.register("some_queue")
    Adsentry::Aggregator.recite.should == ["some_queue"]
  end

  it "reports a hash of queue sizes and members" do
    Adsentry::Annalist.new('some_queue').insert('12345')
    Adsentry::Aggregator.report.should == [{name: "some_queue", count: 1, members: ['12345']}]
  end
end