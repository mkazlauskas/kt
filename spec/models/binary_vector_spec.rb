require 'spec_helper'

describe BinaryVector do
  
  it "can be created" do
    v = BinaryVector.new(elements: "01101011", )
    v.should be_valid
  end

  it "should validate elements" do
    v = BinaryVector.new(elements: "01121011", )
    v.should_not be_valid
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

  it 'to_s returns elements' do
    content = "0101"
    BinaryVector.new(elements: content).to_s.should == content
  end

  describe "*" do
    
    it 'does binary multiplication with other vector' do
      (BinaryVector.new(elements: '1100') *
        BinaryVector.new(elements: '1010')).should ==
          BinaryVector.new(elements: '1000')
    end

    describe 'does matrix multiplication with matrix' do

      let(:rm) { FactoryGirl.create(:reed_muller, r: 2, m: 4, 
        binary_vector: FactoryGirl.create(
          :binary_vector, elements: '01101001010')) }

      it { (rm.binary_vector * rm.generator_matrix).should ==
        BinaryVector.new(elements: '1010111111111010') }
    end
  end
end