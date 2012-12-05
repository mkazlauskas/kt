require 'spec_helper'

describe ApplicationHelper do

  it "should contain error" do

    obj = double("errors")
    count = 1
    message = "Some error happened"
    obj.stub(:count) { count }
    obj.stub(:full_messages) { [ message ] }

    result = format_error_message(obj)
    result.should include "error"
    result.should include count.to_s
    result.should include message
  end
end