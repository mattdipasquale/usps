usps
====

Ruby API for standardizing addresses with USPS WebTools API found here:
http://www.usps.com/webtools/technical.htm

Usage of this library assumes you already have a USPS API account and that all
privileges have been granted.

This gem was forked from http://github.com/gaffneyc/usps.git because:

* I couldn't get it working. I was getting a weird thread error.
* I only wanted support for address standardization.
* I didn't want to use the typhoeus gem cause I was fine making synchronous
  (blocking) requests to the USPS WebTools API.


Exposed API Calls
-----------------

The following USPS API calls are currently exposed through this library:

   <AddressValidateRequest>             -- USPS::Address


How to use?
-----------

This library assumes that either ENV['USPS_USER'] is set, or that you set
USPS.username to your USPS API username.

See http://github.com/mattdipasquale/usps_app


Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add specs for it. This is important so we don't break it in a future version
  unintentionally.
* Commit, do not mess with Rakefile, version, or history. (if you want to have
  your own version, that is fine, but bump version in a commit by itself. I can
  ignore when I pull.)
* Send me a pull request. Bonus points for topic branches.


Copyright (c) 2010 Matt Di Pasquale & Chris Gaffney. See LICENSE for details.
