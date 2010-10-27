require 'rubygems'
require 'rspec/core'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), %w(.. lib)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'usps'

USPS.config.username = 'TESTING'
