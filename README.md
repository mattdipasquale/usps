usps
====

Ruby API for standardizing addresses with the [USPS WebTools API][1]
--------------------------------------------------------------------

This gem was forked from <http://github.com/gaffneyc/usps> because:

* I couldn't get it working. I was getting a weird thread error.
* I only wanted support for address standardization.
* I didn't want to use the typhoeus gem cause I was fine making synchronous
  (blocking) requests to the USPS WebTools API.

If you'd rather not use a gem, you may use the code from this [usps gist][2].


Exposed API Calls
-----------------

The following USPS API calls are currently exposed through this library:

   <AddressValidateRequest>             -- USPS::Address


Instructions
------------

[Request authorization to use the USPS Web Tools Address Information APIs][2].

Set `ENV['USPS_USER']` or `USPS.config.username` to your USPS API username.

See this [example USPS app][3]. Its readme has detailed usage instructions.


Contribute
----------

* Fork the project.
* Add specs for the feature addition or bug fix so that we can make sure
  everything's working after making further developments. Implement.
* Commit and send a pull request. Bonus points for topic branches.

<hr />

Copyright (c) 2010 [Matt Di Pasquale][4] & Chris Gaffney. See MIT-LICENSE.


[1]: http://www.usps.com/webtools/technical.htm
[2]: http://gist.github.com/641363
[3]: http://www.usps.com/webtools/webtoolsapirequestform.htm
[4]: http://github.com/mattdipasquale/usps_app
[5]: http://www.mattdipasquale.com/
