module USPS
  # Configuration options:
  #   username: Get from USPS by registering http://www.usps.com/webtools/
  #   testing: Should requests be done against the testing service or not
  #            (only specific requests are supported).
  class Configuration
    attr_accessor :username, :testing

    def initialize
      self.username = ENV['USPS_USER']
      self.testing  = false
    end
  end
end
