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
- [Travis CI](https://travis-ci.org/Neft-io/neft) - all unit tests,
- [CodeClimate](https://codeclimate.com/github/Neft-io/neft) - lint statistics,
- [Coveralls](https://coveralls.io/github/Neft-io/neft) - code coverage,
- [AppVeyor](https://ci.appveyor.com/project/KrysKruk/neft) - all unit tests running on Windows,
- [SauceLabs](https://saucelabs.com) - all unit tests running on all supported platforms and various devices; reported by *Travis CI*.

These tools may help you write better and well-tested code.
