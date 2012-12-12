require 'spec_helper'

describe StringMessage do
  it "can be created" do
    v = StringMessage.new(message: "Where am I?")
    v.should be_valid
  end

  it "message is required" do
    v = StringMessage.new(message: '')
    v.should_not be_valid
  end

  it "constructs specified length bit sequences" do
    v = StringMessage.new(message: "Some message")
    v.bits_array(7).each do |b|
      b.length.should == 7
      b.each_char do |bit|
        '01'.should include bit
      end
    end
  end

  it "should reconstruct string from given bit sequence" do
    MSG = "Where am I?"
    v = StringMessage.new(message: MSG)
    bits = ''
    v.bits_array(10).each do |b|
      bits << b
    end
    v.load_bits(bits)
    v.message.should == MSG
  end
end
