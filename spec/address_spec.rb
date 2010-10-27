require 'spec_helper'

describe USPS::Address do
  it "should have the expected fields" do
    address = USPS::Address.new

    address.should respond_to(
      :firm_name, :firm_name=,
      :address1, :address1=,
      :address2, :address2=,
      :city, :city=,
      :state, :state=,
      :zip5, :zip5=,
      :zip4, :zip4=
    )
  end

  it "should be initializable with a hash" do
    address = USPS::Address.new(
      :firm_name => 'Chris',
      :address2 => '123 Main St',
      :city => 'Holland'
    )

    address.firm_name.should == 'Chris'
    address.address2.should == '123 Main St'
    address.city.should == 'Holland'
  end

  it "should know how to combine the zip coes" do
    USPS::Address.new(:zip5 => 12345).zip.should == '12345'
    USPS::Address.new(:zip5 => 12345, :zip4 => 9999).zip.should == '12345-9999'
  end

  it "should be able to parse zip into individual parts" do
    address = USPS::Address.new(:zip => '12345-9988')
    address.zip5.should == '12345'
    address.zip4.should == '9988'
    address.zip.should  == '12345-9988'
  end

  it "should be able to be verified with the USPS" do
    address = USPS::Address.new(
      :firm_name => 'President Lincoln',
      :address2 => '1600 Pennsylvania Avenue NW',
      :city => 'Washington',
      :state => 'DC',
      :zip => 20006
    )

    address.expects(:standardize).returns(
      load_xml('address_standardization_1.xml')
    )

    address.valid?.should be_true

    error = USPS::Error.new('error', '1234', 'source')
    # Failure
    USPS.client.expects(:request).raises(error)
    address.valid?.should be_false
    address.error.should be(error)
  end
end
