class USPS::Address
  # requres ruby-1.9, which keeps hashes ordered
  # @@attr_tags = {}
  # [:firm_name, :address1, :address2, :city, :state, :zip5, :zip4].each do |a|
  #   attr_accessor a
  #   @@attr_tags[a] = a.to_s.capitalize.gsub(/_(.)/) { $1.upcase }
  # end

  @@attr_tags = []
  [:firm_name, :address1, :address2, :city, :state, :zip5, :zip4].each do |a|
    attr_accessor a
    @@attr_tags << [a, a.to_s.capitalize.gsub(/_(.)/) { $1.upcase }]
  end
  attr_reader :error

  def initialize(options = {})
    options.each_pair do |k, v|
      self.send("#{k}=", v)
    end
  end

  def zip
    zip4 ? "#{zip5}-#{zip4}" : zip5.to_s
  end

  # Set zip5 & zip4 if given a zip code in the format "99881" or "99881-1234".
  def zip=(val)
    self.zip5, self.zip4 = val.to_s.split('-')
  end

  def valid?
    @error = nil
    standardize
    true
  rescue USPS::Error => e
    @error = e
    false
  end

  def standardize
    # Generate the URI from this Address.
    uri = USPS.server + '?API=Verify&XML=<AddressValidateRequest ' +
          'USERID="' + USPS.config.username + '"><Address ID="0">'
    @@attr_tags.each do |a, t|
      val = self.instance_variable_get "@#{a}"
      uri += '<' + t + '>' + val.to_s + '</' + t + '>'
    end
    uri += '</Address></AddressValidateRequest>'

    # Send the request synchronously and parse the response document.
    doc = Nokogiri::XML(open(URI.encode(uri)))
    if (error = doc.at_css('Error')) # handle error
      description = error.at_css("Description").text
      code = error.at_css('Number').text
      source = error.at_css('Source').text
      raise Error.for_code(code).new(description, code, source)
    else # handle OK responses
      address = Address.new
      root = doc.at_css('Address')
      @@attr_tags.each do |a, t|
        if (node = root.at_css(t)) then address.send("#{a}=", node.text) end
      end
      address # return the address
    end
  end
end
