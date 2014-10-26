Hawking
=======

[![Gem Version](https://badge.fury.io/rb/hawking.png)](http://badge.fury.io/rb/hawking)
[![Build Status](https://travis-ci.org/rogeriozambon/hawking.png?branch=master)](https://travis-ci.org/rogeriozambon/hawking)
[![Code Climate](https://codeclimate.com/github/rogeriozambon/hawking.png)](https://codeclimate.com/github/rogeriozambon/hawking)

Background job queueing using TCPSocket. Inspired in the [Stalker gem](https://github.com/han/stalker).

Queueing jobs
-------------

From anywhere in your app:

~~~.ruby
require "hawking"

hawking = Hawking::Queue.new

hawking.put("email.send", to: "joe@example.com")
hawking.put("post.cleanup", id: post.id)
~~~

Working jobs
------------

In a standalone file, typically jobs.rb or worker.rb:

~~~.ruby
require "hawking"

Hawking::Job.put("email.send") do |data|
  Pony.send(to: data[:to], subject: 'Hello there')
end

Hawking::Job.put("post.cleanup") do |data|
  Post.find(data[:id]).cleanup
end
~~~

Running
-------

Hawking:

    $ gem install hawking

Now run a worker using the binary:

    $ hawking jobs.rb
    Working 2 jobs: [ email.send post.cleanup ]

    Working send.email ({:to=>joe@example.com})
    Working post.cleanup ({:id=>1})

Hawking will log to stdout as it starts working each job.

Running the tests
-----------------

    $ rake spec

Maintainer
----------

* Rogério Zambon (http://rogerio.me)

Licence
-------

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
