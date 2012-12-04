require 'spec_helper'

describe Vector do
  
  it "can be created" do
    v = Vector.new(body: "01", elements: "01101011", size: 8)
    v.should be_valid
  end

  it "should validate size" do
    v = Vector.new(body: "01", elements: "01101011", size: 9)
    v.should_not be_valid
  end

  it "should validate elements" do
    v = Vector.new(body: "01", elements: "01121011", size: 8)
    v.should_not be_valid
  end

  it "does not require to specify size" do
    v = Vector.new(body: "01", elements: "01101011")
    v.should be_valid
  end

  it "requires to specify body" do
    v = Vector.new(elements: "01101011")
    v.should_not be_valid
  end

  it "requires to specify elements" do
    v = Vector.new(body: "01")
    v.should_not be_valid
  end

  it "is iterable" do
    content = "0101"
    v = Vector.new(body: "01", elements: content)
    v.collect { |e| e }.join.should == content
  end

  it "has accesible index" do
    content = "0101"
    v = Vector.new(body: "01", elements: content)
    v[1].should == content[1]
  end
end