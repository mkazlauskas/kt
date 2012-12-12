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

  describe '#encoded_vector' do
    let(:rm) { FactoryGirl.create(:reed_muller, r: 2, m: 4, 
      binary_vector: FactoryGirl.create(
        :binary_vector, elements: '01101001010')) }
    it { rm.encode_vector(rm.binary_vector).should == BinaryVector.new(elements: '1010111111111010') }
  end
end