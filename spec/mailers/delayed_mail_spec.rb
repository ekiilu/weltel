#-  -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ActionMailer::Base do
  before(:each) do
    Delayed::Job.all.each {|j| j.destroy}
    ActionMailer::Base.delivery_method = :delayed
    raise if Delayed::Job.all.length != 0
  end

  it 'should be configured to use delayed mail' do
    ActionMailer::Base.delivery_method.should == :delayed
  end

	it "puts a message into the job queue" do
    ActionMailer::Base.mail(:to => 'test@verticallabs.ca', :from => 'test@verticallabs.ca', :body => 'RSpec tests!').deliver
    Delayed::Job.all.length.should == 1
	end

  it 'recreates the message from the queue correctly' do
    original = ActionMailer::Base.mail(:to => 'test@verticallabs.ca', :from => 'test@verticallabs.ca', :body => 'RSpec tests!').deliver
    copy = Mail::Message.new(Delayed::Job.first.payload_object.args[0])
    original.should == copy
  end
end
