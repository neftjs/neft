# Standard routes

> **API Reference** ▸ [App](/api/app.md) ▸ **Standard routes**

<!-- toc -->

> [`Source`](https://github.com/Neft-io/neft/blob/e37c13b0dda282278ec8cbd4caebd0d5b818c058/src/app/bootstrap/route.node.litcoffee)

## app.js

Returns the application javascript file.


> [`Source`](https://github.com/Neft-io/neft/blob/e37c13b0dda282278ec8cbd4caebd0d5b818c058/src/app/bootstrap/route.node.litcoffee)

## neft.js

Returns the neft javascript file.


> [`Source`](https://github.com/Neft-io/neft/blob/e37c13b0dda282278ec8cbd4caebd0d5b818c058/src/app/bootstrap/route.node.litcoffee)

## favicon.ico

Returns 'static/favicon.ico' file.


> [`Source`](https://github.com/Neft-io/neft/blob/e37c13b0dda282278ec8cbd4caebd0d5b818c058/src/app/bootstrap/route.node.litcoffee)

## static/{path*}

Returns any file from the static/ folder.

## neft-type={type}/*

URI used by the browser which doesn't support javascript - in such case always
full HTML document is returned (like for the searching robots).

You can use this route in a browser to check whether your HTML document is proper.
Clean your cookies when you finish.

```html
<a href="/neft-type=app/">Use CSS renderer</a>
<a href="/neft-type=game/">Use WebGL renderer</a>
<a href="/neft-type=text/">Use text type (robots)</a>
```


> [`Source`](https://github.com/Neft-io/neft/blob/e37c13b0dda282278ec8cbd4caebd0d5b818c058/src/app/bootstrap/route.node.litcoffee)

## Default route

It decides whether the full HTML document should be returned (e.g. for the Googlebot or
text browsers) or the HTML scaffolding which will run **neft.io** on the client side.


> [`Source`](https://github.com/Neft-io/neft/blob/e37c13b0dda282278ec8cbd4caebd0d5b818c058/src/app/bootstrap/route.node.litcoffee)

