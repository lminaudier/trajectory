require 'spec_helper'

describe Hash do
  it 'can symbolize hash keys' do
    hash = {'foo' => 'bar', 'baz' => 'qux'}

    hash.symbolize_keys!

    hash.should == {:foo => 'bar', :baz => 'qux'}
  end
end
