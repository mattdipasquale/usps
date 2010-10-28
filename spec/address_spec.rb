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

  before(:all) do
    @address = USPS::Address.new(
      :address2 => '6406 Ivy Lane',
      :city => 'Greenbelt',
      :state => 'MD'
    )
  end

  it "should be initializable with a hash" do
    @address.address2.should == '6406 Ivy Lane'
    @address.city.should == 'Greenbelt'
    @address.state.should == 'MD'
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

  it "should build the HTTP request" do
    request = 'http://production.shippingapis.com/ShippingAPI(Test)?.dll?API=Verify&XML=<AddressValidateRequest USERID="' + USPS.config.username + '"><Address ID="0"><FirmName></FirmName><Address1></Address1><Address2>' + @address.address2 + '</Address2><City>' + @address.city + '</City><State>' + @address.state + '</State><Zip5></Zip5><Zip4></Zip4></Address></AddressValidateRequest>'
  end

  it "should parse the XML response" do
    success = '<?xml version="1.0"?><AddressValidateResponse><Address ID="0"><Address2>6406 IVY LN</Address2><City>GREENBELT</City><State>MD</State><Zip5>20770</Zip5><Zip4>1441</Zip4></Address></AddressValidateResponse>'
    error = '<?xml version="1.0"?><AddressValidateResponse><Address ID="0"><Error><Number>-2147219079</Number><Source>;SOLServerTest.UnpackAddressNode</Source><Description>Invalid XML Element content is invalid according to the DTD/Schema. Expecting: FirmName, Address1.</Description><HelpFile></HelpFile><HelpContext></HelpContext></Error></Address></AddressValidateResponse>'

    begin
      @address.standardize
    rescue
      error = @address.error
      puts
      puts error.code
      puts error.source
      puts error.message
    end
  end
end
