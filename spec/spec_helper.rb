require 'rubygems'
require 'spec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), %w(.. lib)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'usps-address'

USPS.config.username = 'TESTING'
