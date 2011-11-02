require 'spec_helper'

describe 'Config Server' do

  before(:each) do
    ApplicationHelper.class_eval { def authenticated?; true end }
  end

  it "should return 200 from /version" do
    get '/version'
    last_response.should.be.ok
  end

end
