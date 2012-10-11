#-  -*- encoding : utf-8 -*- 
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require 'spec_helper'

describe ConnectionConfig do
  it 'should write the text to the correct file' do
    c = ConnectionConfig.new
    c.write
    File.exist?(ConnectionConfig::PATH).should == true
    File.open(ConnectionConfig::PATH, 'r').read.should == c.text
  end
end
