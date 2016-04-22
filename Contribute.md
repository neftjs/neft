> [Wiki](Home) ▸ **Contribute**

Neft is a community project. It has no huge company administrator nor a lot of resources. That's why each feedback from the community is so important for the project.

## How to contribute

- Be an active member of the community on [GitHub Issues](https://github.com/Neft-io/neft/issues), [StackOverflow](http://stackoverflow.com/questions/tagged/neft), [Google Group](http://groups.google.com/group/neft_io) or [Gitter](https://gitter.im/Neft-io/neft),
- create *issues* for found bugs and missed features,
- work on wikis, tutorials and API References,
- prepare crazy examples and publish them,
- fix bugs and add new features in CoffeeScript, JavaScript, Swift, C, Java code; learn from community code review,
- don't bite :)

## Repositories organisation

Because the Neft project complexity, each module is placed in separated repository and should be treated as an independent project. Main [Neft repository](https://github.com/Neft-io/neft/) is a place where all of the internal modules must synchronise.

## Requests

If you want to change one of the Neft modules, fork it. If you need to test your changes in a working app, fork the [main repository](https://github.com/Neft-io/neft) and refer specific submodule to your fork. When everything works fine for you, prepare a *Pull Request* to include your changes into the main branch. Each *Pull Request* must be reviewed by the community. It's a good practice to always create an *Issue* with a bug/feature you are working on.

## Testing

Each *Pull Request* is automatically tested by:
- [Travis CI](https://travis-ci.org/Neft-io/neft) - unit tests,
- [CodeClimate](https://codeclimate.com/github/Neft-io/neft) - lint statistics,
- [Coveralls](https://coveralls.io/github/Neft-io/neft) - code coverage.

Each *Pull Request* on the [main repository](https://github.com/Neft-io/neft) is additionally tested by:
- [Travis CI](https://travis-ci.org/Neft-io/neft) - all unit tests,
- [AppVeyor](https://ci.appveyor.com/project/KrysKruk/neft) - all unit tests running on Windows,
- [SauceLabs](https://saucelabs.com) - all unit tests running on all supported platforms and various devices; reported by *Travis CI*.

These tools may help you write better and well-tested code.

## Internal modules

- [Document](https://github.com/Neft-io/neft-document),
- [Renderer](https://github.com/Neft-io/neft-renderer),
- [Android Runtime](https://github.com/Neft-io/neft-android-runtime),
- [iOS Runtime](https://github.com/Neft-io/neft-ios-runtime),
- [App](https://github.com/Neft-io/neft-app),
- [Resources](https://github.com/Neft-io/neft-resources),
- [Networking](https://github.com/Neft-io/neft-networking),
- [Native](https://github.com/Neft-io/neft-native),
- [Utils](https://github.com/Neft-io/neft-utils),
- [Schema](https://github.com/Neft-io/neft-schema),
- [Signal](https://github.com/Neft-io/neft-signal),
- [List](https://github.com/Neft-io/neft-list),
- [Dict](https://github.com/Neft-io/neft-dict),
- [Styles](https://github.com/Neft-io/neft-styles),
- [NML Parser](https://github.com/Neft-io/neft-nml-parser),
- [Typed Array](https://github.com/Neft-io/neft-typed-array),
- [Db](https://github.com/Neft-io/neft-db),
- [Bundle Builder](https://github.com/Neft-io/neft-bundle-builder),
- [Log](https://github.com/Neft-io/neft-log),
- [Unit](https://github.com/Neft-io/neft-unit),
- [Assert](https://github.com/Neft-io/neft-assert).

## GitHub links

You must be logged in.

- [All Issues](https://github.com/issues?q=is%3Aissue+user%3ANeft-io+is%3Aopen),
- [All Pull requests](https://github.com/issues?utf8=%E2%9C%93&q=is%3Apr+user%3ANeft-io+is%3Aopen+).