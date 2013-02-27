require 'spec_helper'

module Trajectory
  describe MissingAttributeError do
    it 'is able to display an error message when given attribute is nil in given object' do
      object = Object.new
      MissingAttributeError.new(object, :some_nil_attribute).to_s.should == "Attribute #{:some_nil_attribute} of #{object.inspect} is nil."
    end
  end
end
