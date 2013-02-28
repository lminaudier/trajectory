require 'spec_helper'

module Trajectory
  describe Idea do
    let(:idea) { Idea.new(id: 42, subject: 'foo') }

    it 'can be initialized with named parameters' do
      idea.id.should == 42
      idea.subject.should == 'foo'
    end

    it 'requires an id attribute' do
      expect do
        Idea.new.id
      end.to raise_error(MissingAttributeError)
    end

    it 'is the same idea when ids are the same' do
      idea.should == Idea.new(id: 42, subject: 'bar')
    end

    context 'it has attributes accessors' do
      %w(id subject stories_count comments_count last_comment_user_name last_comment_created_at editable_by_current_user user_id subscribed_user_ids project_id).each do |attribute|
        it "'#{attribute}' accessor" do
          Idea.new.should respond_to(attribute.to_sym)
        end
      end
    end

    it 'delegates project fetching to data store' do
      DataStore.should_receive(:find_project_by_id)

      Idea.new.project
    end
  end
end
