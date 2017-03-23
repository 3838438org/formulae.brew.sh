braumeister.org
===============

[![Build Status](https://secure.travis-ci.org/koraktor/braumeister.org.svg)](http://travis-ci.org/koraktor/braumeister.org)
[![Dependency Status](https://gemnasium.com/koraktor/braumeister.org.svg)](https://gemnasium.com/koraktor/braumeister.org)
[![Code Climate](https://codeclimate.com/github/koraktor/braumeister.org.svg)](https://codeclimate.com/github/koraktor/braumeister.org)
[![Coverage Status](https://img.shields.io/coveralls/koraktor/braumeister.org.svg)](https://coveralls.io/r/koraktor/braumeister.org)

[![Gratipay](https://img.shields.io/gratipay/team/Braumeister.svg)](https://gratipay.org/Braumeister)
[![Beerpay](https://img.shields.io/beerpay/koraktor/braumeister.org.svg)](https://beerpay.io/koraktor/braumeister.org)

braumeister.org is a Rails application that gathers package information from
Homebrew, the MacOS X package manager.

## Internals

To get information about the packages currently available via Homebrew, the
application has its own clone of Homebrew's Git repository. Homebrew's raw
package files, the so called formulae (or formulas) which are Ruby classes, are
used to gather information from the packages.

Because Homebrew isn't currently optimized for third party access, there is
some need to sandbox Homebrew's code, so we don't mess up with our
application's code. This is done by forking another Ruby process and using an
`IO#pipe` for inter-process communication (IPC). The formula data is passed as
marshalled `Hash`es from the indexing process (child) to the main process
(parent).

There are other, probably better methods of IPC like shared memory, but piping
was easy to implement and proved to be fast enough even for full indexing with
several hundred formulae.

## Local setup

If you clone the repository from GitHub it's pretty easy to get started with
a working local copy. You'll need to create a local MongoDB database first:

```bash
mongo
> use braumeister
> db.addUser("braumeister", "braumeister")
```

After that you can run the following commands to run the application locally:

```ruby
bundle install
rake db:seed
foreman start
```

## Contribute

braumeister.org is an open-source project. Therefore you are free to help
improving it. There are several ways of contributing to braumeister.org's
development:

 * Use it and spread the word to existing and new Homebrew users
 * Report problems and request features using the [issue tracker][2].
 * Write patches yourself to fix bugs and implement new functionality.
 * Create a fork on [GitHub][1] and start hacking. Extra points for using
   feature branches and GitHub's pull requests.

## About the name

"Braumeister" – [ˈbʁaʊmʌɪstəʀ] – is the German word for "master brewer" or
"brewmaster", the person in charge of beer production.

## License

This code is free software; you can redistribute it and/or modify it under the
terms of the new BSD License. A copy of this license can be found in the
LICENSE file.

## Credits

 * Sebastian Staudt – koraktor(at)gmail.com
 * Andrey Ognevsky – a.ognevsky(at)gmail.com
 * Michiel Staessen – staessenmichiel(at)gmail.com

## See also

 * [GitHub project page][1]
 * [GitHub issue tracker][2]
 * [Homebrew][3]
 * [Continuous Integration at Travis CI][5]
 * [Dependency status at Gemnasium][4]

Follow braumeister.org on Twitter
[@braumeister_org](http://twitter.com/braumeister_org).

 [1]: https://github.com/koraktor/braumeister.org
 [2]: https://github.com/koraktor/braumeister.org/issues
 [3]: http://brew.sh
 [4]: https://gemnasium.com/koraktor/braumeister.org
 [5]: https://travis-ci.org/koraktor/braumeister.org
