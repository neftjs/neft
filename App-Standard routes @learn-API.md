> [Wiki](Home) ▸ [API Reference](API-Reference)

Standard routes
<dl><dt>Syntax</dt><dd>Standard routes @learn</dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/app/bootstrap/route.node.litcoffee#standard-routes-learn)

##js
<dl><dt>Syntax</dt><dd>app.js</dd><dt>Static property of</dt><dd><i>app</i></dd></dl>
Returns the application javascript file.

> [`Source`](/Neft-io/neft/tree/master/src/app/bootstrap/route.node.litcoffee#appjs)

##js
<dl><dt>Syntax</dt><dd>neft.js</dd><dt>Static property of</dt><dd><i>neft</i></dd></dl>
Returns the neft javascript file.

> [`Source`](/Neft-io/neft/tree/master/src/app/bootstrap/route.node.litcoffee#neftjs)

##ico
<dl><dt>Syntax</dt><dd>favicon.ico</dd><dt>Static property of</dt><dd><i>favicon</i></dd></dl>
Returns 'static/favicon.ico' file.

> [`Source`](/Neft-io/neft/tree/master/src/app/bootstrap/route.node.litcoffee#faviconico)

## static/{path*}

Returns any file from the static/ folder.

##neft-type/*
<dl><dt>Syntax</dt><dd>neft-type={type}/*</dd><dt>Default</dt><dd><code>{type}</code></dd></dl>
URI used by the browser which doesn't support javascript - in such case always
full HTML document is returned (like for the searching robots).
You can use this route in a browser to check whether your HTML document is proper.
Clean your cookies when you finish.
```html
<a href="/neft-type=app/">Use CSS renderer</a>
<a href="/neft-type=game/">Use WebGL renderer</a>
<a href="/neft-type=text/">Use text type (robots)</a>
```

> [`Source`](/Neft-io/neft/tree/master/src/app/bootstrap/route.node.litcoffee#nefttypetype)

## Default route

It decides whether the full HTML document should be returned (e.g. for the Googlebot or
text browsers) or the HTML scaffolding which will run **neft.io** on the client side.

> [`Source`](/Neft-io/neft/tree/master/src/app/bootstrap/route.node.litcoffee#default-route)

