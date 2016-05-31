> [Wiki](Home) ▸ [[API Reference|API-Reference]] ▸ [[App|App-API]] ▸ **Standard routes**

# Standard routes

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/app/bootstrap/route.node.litcoffee#standard-routes)

## Table of contents
* [Standard routes](#standard-routes)
  * [js](#js)
  * [js](#js)
  * [ico](#ico)
  * [static/{path*}](#staticpath)
  * [neft-type={type}/*](#nefttypetype)
  * [Default route](#default-route)

##js
<dl><dt>Syntax</dt><dd><code>app.js</code></dd><dt>Static property of</dt><dd><i>app</i></dd></dl>
Returns the application javascript file.

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/app/bootstrap/route.node.litcoffee#js)

##js
<dl><dt>Syntax</dt><dd><code>neft.js</code></dd><dt>Static property of</dt><dd><i>neft</i></dd></dl>
Returns the neft javascript file.

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/app/bootstrap/route.node.litcoffee#js)

##ico
<dl><dt>Syntax</dt><dd><code>favicon.ico</code></dd><dt>Static property of</dt><dd><i>favicon</i></dd></dl>
Returns 'static/favicon.ico' file.

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/app/bootstrap/route.node.litcoffee#ico)

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

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/app/bootstrap/route.node.litcoffee#nefttypetype)

## Default route

It decides whether the full HTML document should be returned (e.g. for the Googlebot or
text browsers) or the HTML scaffolding which will run **neft.io** on the client side.

> [`Source`](/Neft-io/neft/blob/564f8d734f4e3d2b9c5aa3d8f0b6cad0c8b3f9f0/src/app/bootstrap/route.node.litcoffee#default-route)

