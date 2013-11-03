require 'spec_helper'

describe Adsentry::Alerter do

  it "can return a timeseries event" do
    Adsentry::Alerter.record(:associaton).should == 1
  end

  it "can return the elapsed time since an event" do
    Adsentry::Alerter.record(:associaton)
    Adsentry::Alerter.since_last_event(:associaton).should == 1
  end
end