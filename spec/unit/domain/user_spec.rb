require 'spec_helper'

module Trajectory
  describe User do
    let(:idea) { User.new(id: 42, name: 'foo') }

    it 'can be initialized with named parameters' do
      idea.id.should == 42
    end

    it 'requires an id attribute' do
      expect do
        User.new.id
      end.to raise_error(MissingAttributeError)
    end

    it 'is the same idea when ids are the same' do
      idea.should == User.new(id: 42, name: 'bar')
    end

    context 'it has attributes accessors' do
      %w(id name updated_at created_at gravatar_url email).each do |attribute|
        it "'#{attribute}' accessor" do
          User.new.should respond_to(attribute.to_sym)
        end
      end
    end
  end
end
