Template
========

	'use strict'

	assert = require 'neft-assert'
	utils = require 'utils'
	log = require 'log'

	Document = require 'document'
	Networking = require 'networking'

	log = log.scope 'App', 'Template'

	CONFIG_KEYS = [] # filled by the class properties

	module.exports = (app) -> class AppTemplate

*Template* Template(*Object* options)
-------------------------------------

This class is used to create view template - an HTML document which is used as a
scaffolding for rendered views.

There should be created in **templates/** folder files and
are available by the **app.templates** object.

Access it with:
```
module.exports = function(app){
  var Template = app.Template;
};
```

		constructor: (opts) ->
			assert.instanceOf @, AppTemplate
			assert.isPlainObject opts

			# check for unprovided options
			assert do ->
				optsKeys = utils.merge Object.keys(opts), CONFIG_KEYS
				utils.isEqual(CONFIG_KEYS, optsKeys)
			, "Unprovided config key has been passed into `app.Template`:\n" +
			  "#{JSON.stringify opts, null, 4}"

			# view
			setView @, opts.view

			# viewTargetUse
			setViewTargetUse @, opts.viewTargetUse

			# data
			if opts.data?
				setData @, opts.data

			# set object as immutable
			Object.freeze @

*app.View* Template::view
-------------------------

Instance of an [app.View][] or path to the **views/** file in the **app.views** object.

		view: null

		CONFIG_KEYS.push 'view'

		setView = (ctx, val) ->
			assert.instanceOf ctx, AppTemplate

			if typeof val is 'string'
				view = app.views[val]

				assert view
				, "`#{val}` view file can't be found"
			else
				assert.instanceOf val, app.View

				view = val

			ctx.view = view

*String* Template::viewTargetUse
--------------------------------

First [neft:use][] pointing at this fragment name will be replaced by the proper [app.View][].

```
// templates/index.js
module.exports = function(app){
  return new app.Template({
    view: 'index',
    viewTargetUse: 'body'
  });
}

// views/index.html
<body>
  <main>
    <neft:use neft:fragment="body" />
  </main>
  <aside>
  </aside>
</body>
```

		viewTargetUse: ''

		CONFIG_KEYS.push 'viewTargetUse'

		setViewTargetUse = (ctx, val) ->
			assert.instanceOf ctx, AppTemplate
			assert.isString val

			ctx.viewTargetUse = val

*Any* Template::data
--------------------

Default data available in the HTML document by the **data** object
(as it is described in the [DocumentGlobalData][]).

Notice, that this data can be a [Dict][] or a [List][] and can be modified at runtime
(works just like **app.Route** or **app.Controller** data).

```
// templates/index.js
var Dict = require('dict');
module.exports = function(app){
  var data = new Dict({time: Date.now()});
  setInterval(function(){
    data.set('time', Date.now());
  }, 1000);

  return new app.Template({
    view: 'index',
    viewTargetUse: 'body',
    data: data
  });
}

// views/index.html
<body>
  <main>
    <neft:use neft:fragment="body" />
  </main>
  <aside>
    Current time: ${data.time}
  </aside>
</body>
```

		data: null

		CONFIG_KEYS.push 'data'

		setData = (ctx, val) ->
			assert.instanceOf ctx, AppTemplate

			ctx.data = val

		_render: (req) ->
			assert.instanceOf @, AppTemplate
			assert.instanceOf req, Networking.Request

			view = @view.render req, @data

			view

		_renderTarget: (document, target) ->
			for use in document.uses
				if use.name is @viewTargetUse
					elem = use
					break

			assert elem
			, "app.Template `#{@view.document.path}` view doesn't have any `#{@viewTargetUse}` use"

			elem.usedFragment = null # avoid destroying target, it's AppRoute job
			elem.render target
