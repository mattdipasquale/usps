module USPS
  class Error < StandardError
    attr_reader :code, :source

    def initialize(code, source, message)
      @code = code
      @source = source
      super(message)
    end

    def self.for_code(code)
      case code
      when '80040b1a'   ; AuthorizationError
      when '80040b19'   ; InvalidXMLError
      when '-2147219079'; InvalidDTDError
      when '-2147219400'; InvalidCityError
      when '-2147219401'; AddressNotFoundError
      when '-2147219402'; InvalidStateError
      when '-2147219403'; MultipleAddressError
      else              ; Error
      end
    end
  end

  class AuthorizationError < Error; end
  class ValidationError < Error; end
  class InvalidXMLError < ValidationError; end
  class InvalidDTDError < ValidationError; end
  class InvalidCityError < ValidationError; end
  class InvalidStateError < ValidationError; end
  class AddressNotFoundError < ValidationError; end
  class MultipleAddressError < ValidationError; end
end
