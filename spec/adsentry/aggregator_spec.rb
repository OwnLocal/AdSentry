require 'spec_helper'

describe Adsentry::Aggregator do

  it "registers a queue with itself" do
    Adsentry::Aggregator.register("adsentry:some_queue")
  end

  it "recites the queues as a list" do
    Adsentry::Aggregator.register("adsentry:some_queue")
    Adsentry::Aggregator.recite.should == ["adsentry:some_queue"]
  end

  it "reports a hash of queue sizes" do
    Adsentry::Aggregator.register("adsentry:some_queue")
    Adsentry::Aggregator.report.should == [{name: "adsentry:some_queue", count: 0}]
  end
end