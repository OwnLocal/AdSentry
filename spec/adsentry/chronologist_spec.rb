require 'spec_helper'

describe Adsentry::Chronologist do
  before(:each) do
    Adsentry::Chronologist.record(:associaton, :some_identifier)
  end

  it "can return the elapsed time since an event" do
    Adsentry::Chronologist.since_last_event(:associaton).should < 1
  end

  it "can return the last n values" do
    Adsentry::Chronologist.last_members(:association).size.should == 1
  end
end