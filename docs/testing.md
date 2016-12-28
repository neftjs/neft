# Testing

Neft provides module for easy testing your code on different platforms.

Test files needs to be placed in **tests** folder.

Use `neft test` command to run your tests.

## Test case

Use global `it` function to declare your first test.

This method accepts short description and function with your test case.

```javascript
it('1+1 is 2', () => {
    assert(1+1 === 2);
});
```

If your test throws an exception (using `throw new Error('...')` or by [assertions](/api/assert.html)), it's automatically marked as failed.

## Nesting

Use global `describe` function and declare a container for tests.

It works just like `it`, but expects tests or other groups inside.

```javascript
const sum = (a, b) => a + b;

describe('sum method', () => {
    it('adds both parameters', () => {
        assert(sum(1, 2) === 3);
    });
});
```

## Assertions

Writing conditions and throwing errors each time your result is wrong can be boring.

Boring coding is bad.

To make comparisons more compact, use [assert](/api/assert.html) module.

It provides a lot of helpful methods, like:
 - [`assert.isString()`](/api/assert.html#assertisstring),
 - [`assert.instanceOf()`](/api/assert.html#assertinstanceof),
 - [`assert.isEqual()`](/api/assert.html#assertisequal),
 - and [more](/api/assert.html).

## App

Global `app` object is your application just like in other files.

Use it to access e.g. models (`app.models`) or views (`app.views`).

Let's assume, we have a view `PlusButton.xhtml` like below:

```xhtml
<script>
this.onCreate(function () {
    this.increment = () => {
        this.state.set('value', this.state.value + 1);
    };
});

this.onRender(function () {
    this.state.set('value', 0);
});
</script>

<button n-style:pointer:onClick="${this.increment()}">Increment</button>
```

... and we want to test whether `increment` method works like a charm.

```javascript
describe('PlusButton', () => {
    let view;

    beforeEach(() => {
        view = app.views['views/PlusButton.xhtml'].render();
    });

    describe('increment()', () => {
        it('increments state.value', () => {
            view.scope.increment();
            assert.is(view.scope.state.value, 1);
            view.scope.increment();
            assert.is(view.scope.state.value, 2);
            // hooray !
        });
    });
});
```

## Asynchronous test

Global function `it` can provide `callback` parameter.

Use it to run asynchronous tests.

If your test fails, run `callback` parameter with an error.

Otherwise call it with no extra parameters.

```javascript
it('callback works just fine', (callback) => {
    setTimeout(() => {
        if (1 + 1 === 0) {
            callback(new Error('Ops..!'));
        } else {
            callback();
        }
    }, 100);
});
```

## Before and after

Global `beforeEach` and `afterEach` function can be used to run piece of code before and after each test in `describe`.

```javascript
describe('foo', () => {
    let foo;

    beforeEach(() => {
        foo = 0;
        foo += 1;
    });

    afterEach(() => {
        foo = 0;
    });

    it('is one; Mr obvious?', () => {
        assert.is(foo, 1);
    });
});
```

## Different environments

All tests by default are running as Node server (`npm run node`).

By typing `neft test` you can run your tests just like client runs your application.

Specify `testing.json` file with list of environments you want to test.

YAML is supported as well, so your file can be called `testing.yml`.

To run your tests in Node and in a Chrome browser, specify `testing.json` as below:

```json
{
    "environments": [
        {
            "platform": "node",
            "version": "current",
        },
        {
            "platform": "browser",
            "browser": "chrome"
        }
    ]
}
```
