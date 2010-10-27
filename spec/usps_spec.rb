require 'spec_helper'

describe USPS do
  before(:each) do
    @server = 'http://production.shippingapis.com/'
    USPS.configure do |config|
      config.username = 'mattdipasquale'
      config.testing  = true
    end
  end

  it "should allow configuration" do
    USPS.config.username.should == 'mattdipasquale'
    USPS.config.testing.should == true
  end

  it "should return the correct server" do
    USPS.server.should == @server + 'ShippingAPITest.dll'
    USPS.config.testing = false
    USPS.server.should == @server + 'ShippingAPI.dll'
  end
end
