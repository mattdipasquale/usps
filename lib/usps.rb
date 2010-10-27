require 'nokogiri'
require 'open-uri'

module USPS
  SERVER = 'http://production.shippingapis.com/'
  require 'usps/address'
  require 'usps/configuration'
  require 'usps/errors'

  class << self
    def config
      @config ||= Configuration.new
    end
    attr_writer :config

    def configure(&block)
      block.call(self.config)
    end

    def server
      SERVER + config.testing ? "ShippingAPITest.dll" : "ShippingAPI.dll"
    end
  end
end
