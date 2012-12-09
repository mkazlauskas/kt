require 'spec_helper'

describe BinaryVector do
  
  it "can be created" do
    v = BinaryVector.new(elements: "01101011", size: 8)
    v.should be_valid
  end

  it "should validate size" do
    v = BinaryVector.new(elements: "01101011", size: 9)
    v.should_not be_valid
  end

  it "should validate elements" do
    v = BinaryVector.new(elements: "01121011", size: 8)
    v.should_not be_valid
  end

  it "does not require to specify size" do
    v = BinaryVector.new(elements: "01101011")
    v.should be_valid
  end

  it "requires to specify elements" do
    v = BinaryVector.new
    v.should_not be_valid
  end

  it "is iterable" do
    content = "0101"
    v = BinaryVector.new(elements: content)
    v.collect { |e| e }.join.should == content
  end

  it "has accesible index" do
    content = "0101"
    v = BinaryVector.new(elements: content)
    v[1].should == content[1]
  end

  it "== compares elements" do
    content = "0101"
    BinaryVector.new(elements: content).
      should == BinaryVector.new(elements: content)
  end

  it "* does binary multiplication" do
    (BinaryVector.new(elements: '1100') *
      BinaryVector.new(elements: '1010')).should ==
        BinaryVector.new(elements: '1000')
  end
end