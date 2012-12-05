require 'spec_helper'

describe ReedMuller do

  it "can create reed-muller" do
    rm = ReedMuller.new(r: 4, m: 5)
    rm.should be_valid
  end

  it "r must be set" do
    rm = ReedMuller.new(m: 5)
    rm.should_not be_valid
  end

  it "m must be set" do
    rm = ReedMuller.new(r: 5)
    rm.should_not be_valid
  end
  
  it "r should be greater than 0" do
    rm = ReedMuller.new(r: -1, m: 3)
    rm.should_not be_valid
  end

  it "r should be less or equal to m" do
    rm = ReedMuller.new(r: 6, m: 5)
    rm.should_not be_valid
  end

  it "m can be equal to r" do
    rm = ReedMuller.new(r: 5, m: 5)
    rm.should be_valid
  end
end