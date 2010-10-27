require 'spec_helper'

describe USPS::Configuration do
  before(:each) do
    ENV['USPS_USER'] = nil
    @config = USPS::Configuration.new
  end

  it "should have the expected fields" do
    @config.should respond_to(
      :username, :username=,
      :testing, :testing=
    )
  end

  it "should have some sensible defaults" do
    @config.username.should be_nil
    @config.testing.should be_false
  end

  it "should grab the username from the environment if available" do
    ENV['USPS_USER'] = 'mattdipasquale'
    USPS::Configuration.new.username.should == 'mattdipasquale'
  end
end
