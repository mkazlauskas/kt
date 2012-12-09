require 'spec_helper'

describe MathHelper do
  describe "#num_combinations" do
    it "returns number of combinations" do
      helper.num_combinations(4, 2).should == 6
    end
  end  
end
