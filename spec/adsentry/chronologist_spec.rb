require 'spec_helper'

describe Adsentry::Chronologist do
  before(:each) do
    $ADSENTRY_REDIS.flushdb
    Adsentry::Chronologist.record(:association, :some_identifier)
  end

  it "can return the elapsed time since an event" do
    Adsentry::Chronologist.since_last_event(:association).should < 1
  end

  it "can return the last n values" do
    Adsentry::Chronologist.last_times(:association).size.should == 1
  end
end