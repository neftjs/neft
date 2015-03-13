View
====

	'use strict'

	utils = require 'utils'
	assert = require 'neft-assert'
	signal = require 'signal'
	log = require 'log'

	Dict = require 'dict'
	Document = require 'document'
	Networking = require 'networking'

	log = log.scope 'App', 'View'

	module.exports = (app) -> class AppView

*View* View(*Document* document)
--------------------------------

This class represents an HTML document.

You don't have to use it manually, because all files from the **views/** folder
are automatically wrapped in this class and are available in the **app.views** object.

Access it with:
```
module.exports = function(app){
  var View = app.View;
};
```

		constructor: (@document) ->
			assert.instanceOf @, AppView
			assert.instanceOf document, Document

*Document* View::document
-------------------------

		document: null

*Document* View::render(*Networking.Request* req, [*Object* data])
------------------------------------------------------------------

		render: (req, data) ->
			assert.instanceOf req, Networking.Request

			document = Document.factory @document.path

			# data
			oldReq = DocumentGlobalData.request
			utils.defineProperty DocumentGlobalData, 'request', utils.CONFIGURABLE, req
			DocumentGlobalData.requestChanged(oldReq)

			dataObj = Object.create DocumentGlobalData
			dataObj.global = dataObj
			dataObj.data = data

			document.storage = dataObj
			document.render()

			document

*Object* DocumentGlobalData
---------------------------

When using **app.View**, this object is automatically set as an HTML document global data
used in the string interpolation.

		DocumentGlobalData = {}

*DocumentGlobalData* DocumentGlobalData.global
----------------------------------------------

It's just a cyclic reference introduced for safety
(until you don't override *global* keyword in your HTML document).

		DocumentGlobalData.global = null

*Any* DocumentGlobalData.data
-----------------------------

Got data from the **app.Route**.

Your data from, for example, **app.Controller** is available here.

```
// routes/index.js
module.exports = function(app){
  new app.Route({
    uri: 'welcome',
    callback: function(req, res, callback){
      callback(null, { name: 'Lily' });
    }
  });
};

// views/welcome.html
<main>
  Hi ${data.name}!
  <!-- Hi Lily! -->

  Hi ${global.data.name}!
  <!-- Hi Lily! -->
</main>
```

		DocumentGlobalData.data = null

*Signal* DocumentGlobalData.requestChanged(*Networking.Request* oldRequest)
---------------------------------------------------------------------------

		signal.create DocumentGlobalData, 'requestChanged'

*NeftApp* DocumentGlobalData.app
--------------------------------

Reference into the **app** object.

```
<neft:func name="creepyCode">
  global.app.networking.createRequest({ uri: 'why/not/in/the/controller?' })
</neft:func>
```

		utils.defineProperty DocumentGlobalData, 'app', null, app

*Networking.Request* DocumentGlobalData.request
-----------------------------------------------

Reference to the current considered request.

**DocumentGlobalData.requestChanged()** signal is called when this property change.

		utils.defineProperty DocumentGlobalData, 'request', utils.CONFIGURABLE, null

*Dict* DocumentGlobalData.uri
-----------------------------

Custom [Dict][] object which can be used to get current request parameters, change them,
or even redirect to the other URI.

```
<neft:func name="thisShouldBeALink">
  global.uri.get('paramName');
  global.uri.set('page', global.uri.get('page') + 1);
  global.uri = 'articles/funny';
</neft:func>
```

		utils.defineProperty DocumentGlobalData, 'uri', null, do ->
			dict = Object.create new Dict
			req = null

			newRequestGoing = false
			onDictChanged = ->
				return if newRequestGoing
				newRequestGoing = true

				savedReq = req
				setImmediate ->
					newRequestGoing = false

					if savedReq isnt req
						log.info "Changed `uri` won't be proceeded due to new request"
						return

					app.httpNetworking.createRequest
						method: Networking.Request.GET
						type: Networking.Request.HTML_TYPE
						uri: req.handler.uri.toString dict

			dict.onChanged onDictChanged

			DocumentGlobalData.onRequestChanged ->
				req = @request

				dict.onChanged.disconnect onDictChanged

				# remove missed params
				for key in dict.keys()
					unless req.params.hasOwnProperty key
						dict.pop key

				# set new params
				for key, val of req.params
					dict.set key, val

				dict.onChanged onDictChanged

*Dict* DocumentGlobalData.uri.toString([*Any* params])
------------------------------------------------------

Works like [Networking.Uri::toString][] if *params* are given, otherwise it returns
current request uri.

```
<span>Your current URI: ${global.uri}</span>

<a href="/${global.uri.toString({page: global.uri.get('page') + 1})}">Show next page</a>

<!-- it's equal to ... -->
<a href="/${global.request.handler.uri.toString({page: global.uri.get('page') + 1})}">Show next page</a>
```

			dict.toString = (params) ->
				if params
					req.handler.uri.toString params
				else
					req.uri

			-> dict

		, (val) ->
			app.httpNetworking.createRequest
				method: Networking.Request.GET
				type: Networking.Request.HTML_TYPE
				uri: val
