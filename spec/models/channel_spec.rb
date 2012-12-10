require 'spec_helper'

describe Channel do

  describe 'validates reliability' do
    it { Channel.new.should_not be_valid }
    it { Channel.new(reliability: 101).should_not be_valid }
    it { Channel.new(reliability: 0).should_not be_valid }
    it { Channel.new(reliability: 1).should be_valid }
    it { Channel.new(reliability: 100).should be_valid }
  end

  describe "valid reliability" do
    let(:channel) { Channel.new(reliability: 80) }

    it { channel.should be_valid }

    describe '#send_vector' do

      let(:vector) { BinaryVector.new(elements: '0111100000001111110101010101100001111') }
      let(:result) { channel.send_vector(vector) }
      it { result[0].should_not == vector }
      it { result[1].count.should_not == 0 }
      it { result[1][0].is_a?(Integer).should == true }

    end
  end
end