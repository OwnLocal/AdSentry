require 'spec_helper'

describe Adsentry::Annalist do
  it "can be initialized" do
    Adsentry::Annalist.new
  end

  let(:it) {Adsentry::Annalist.new}

  it "records an ad entering a queue" do
    it.insert(:needs_image_extracting, 12345)
  end

  it "records an ad exiting a queue" do
    it.remove(:needs_image_extracting, 12345)
  end

  it "returns :not_in_queue if the ad was not in the queue" do
    result = it.remove(:needs_image_extracting, 12345)
    result.should == :not_in_queue
  end

  it "returns the ad_id if the ad was indeed in the queue" do
    it.insert(:needs_image_extracting, 12345)
    result = it.remove(:needs_image_extracting, 12345)
    result.should == 12345
  end
end