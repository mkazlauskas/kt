require 'spec_helper'

describe ReedMullerHelper do
  
  describe '#majority_logic_decoder' do

    let(:rm) { FactoryGirl.create(:reed_muller) }
    it { helper.majority_logic_decoder(rm.generator_matrix, 
      rm.channel.send_vector(rm.encoded_vector)).should == rm.binary_vector }
  end
end