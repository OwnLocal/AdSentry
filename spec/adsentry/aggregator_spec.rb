require 'spec_helper'

describe Adsentry::Aggregator do

  it "registers a queue with itself" do
    Adsentry::Aggregator.register("some_queue")
  end

  it "recites the queues as a list" do
    Adsentry::Aggregator.register("some_queue")
    Adsentry::Aggregator.recite.should == ["some_queue"]
  end

  it "reports a hash of queue sizes" do
    Adsentry::Aggregator.register("some_queue")
    Adsentry::Aggregator.report.should == {"some_queue" => 0}
  end
end