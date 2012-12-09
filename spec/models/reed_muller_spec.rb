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

  describe '#generator_matrix' do
    it "should return a generator matrix" do
      ReedMuller.new(r: 2, m: 4).generator_matrix.should_not be_nil
    end
  end

  describe '#new_message' do
    it "should create a vector with correct size" do
      ReedMuller.new(r: 2, m: 4).new_message.size.should == 11
      ReedMuller.new(r: 2, m: 3).new_message.size.should == 7
      ReedMuller.new(r: 1, m: 3).new_message.size.should == 4
      ReedMuller.new(r: 1, m: 2).new_message.size.should == 3
      ReedMuller.new(r: 1, m: 4).new_message.size.should == 5
      ReedMuller.new(r: 2, m: 2).new_message.size.should == 4
    end

    it "should return nil if reed muller is invalid" do
      ReedMuller.new(r: 2).new_message.should be_nil
    end
  end
end