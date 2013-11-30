App
===

High-level API to build in easy way complex solutions (server + client).

`App` fully uses all defined modules such as *database* connection, *models*,
*routes*, *schemas*, *views* etc.

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	cluster = require 'cluster'
	os = require 'os'

	if cluster.isWorker then throw new ReferenceError

Clusters
--------

Created apps used all of available *cpus*.

	cluster.setupMaster
		exec: 'cluster.coffee.md'

	runApp = (opts) ->

		fork = ->

			worker = cluster.fork()

			worker.on 'online', ->
				setTimeout (-> worker.send opts), 500 # BUG

		fork() for i in [0...os.cpus().length] by 1

		cluster.on 'exit', -> fork()

Public *API*
------------

### run(*Object*...)

Register and run specified applications.
This method can be run only once.

Available options per *app* are:
 - *required* **name** - name of the application,
 - *required* **port** - port to listen on,
 - **path** - path to *app* structure; by defult it's a *name*

	exports.run = do (run = false) -> (apps...) ->

		assert not run
		run = true

		for opts in apps

			assert utils.isObject opts
			assert opts.name and typeof opts.name is 'string'
			assert opts.port > 0 and typeof opts.port is 'number'
			opts.path and assert typeof opts.path is 'string'

			runApp opts