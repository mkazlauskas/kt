require 'spec_helper'

describe GeneratorMatrix do
  let(:num_rows) { 4 }
  let(:num_cols) { 8 }
  
  it "can be created" do
    g = GeneratorMatrix.new(rows: num_rows, cols: num_cols)
    g.should be_valid
  end

  it "rows is required" do
    g = GeneratorMatrix.new(cols: num_cols)
    g.should_not be_valid
  end

  it "cols is required" do
    g = GeneratorMatrix.new(rows: num_rows)
    g.should_not be_valid
  end

  it "cols value must 2**something" do
    g = GeneratorMatrix.new(rows: num_rows, cols: 7)
    g.should_not be_valid
  end

  it "should be of rows size" do
    g = GeneratorMatrix.new(rows: num_rows, cols: num_cols)
    g.count.should == num_rows
  end

  it "can access cell" do
    g = GeneratorMatrix.new(rows: num_rows, cols: num_cols)
    g[1][4].should_not be_nil
  end

  it "is a correct generator matrix" do
    g = GeneratorMatrix.new(rows: 11, cols: 16)
    g[0].should == BinaryVector.new(elements: '1111111111111111')
    g[1].should == BinaryVector.new(elements: '1111111100000000')
    g[2].should == BinaryVector.new(elements: '1111000011110000')
    g[3].should == BinaryVector.new(elements: '1100110011001100')
    g[4].should == BinaryVector.new(elements: '1010101010101010')
    g[5].should == BinaryVector.new(elements: '1111000000000000')
    g[6].should == BinaryVector.new(elements: '1100110000000000')
    g[7].should == BinaryVector.new(elements: '1010101000000000')
    g[8].should == BinaryVector.new(elements: '1100000011000000')
    g[9].should == BinaryVector.new(elements: '1010000010100000')
    g[10].should == BinaryVector.new(elements: '1000100010001000')
  end
end