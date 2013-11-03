require 'spec_helper'

describe Adsentry::Alerter do

  it "can return a timeseries event" do
    Adsentry::Alerter.record(:associaton).should == 1
  end
end