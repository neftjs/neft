App Cluster
===========

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	cluster = require 'cluster'
	express = require 'express'

	if cluster.isMaster then throw new ReferenceError

Worker
------

*Worker* starts an *App* on message with *opts*.

	process.on 'message', (opts) -> new App(opts)

*class* App
-----------

	cluster.isWorker and class App

### Constructor

		constructor: (opts) ->

			assert utils.isObject opts

			console.log opts