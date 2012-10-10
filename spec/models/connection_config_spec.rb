require 'spec_helper'

describe ConnectionConfig do
  it 'should write the text to the correct file' do
    c = ConnectionConfig.new
    c.write
    File.exist?(ConnectionConfig::PATH).should == true
    File.open(ConnectionConfig::PATH, 'r').read.should == c.text
  end
end
