'use strict'

App = require '../index.coffee.md'
App.run
	name: 'test'
	port: 3000


###
cluster = require 'cluster'
if (cluster.isMaster)
  worker = cluster.fork();

  worker.on 'fork', -> console.log 'event fork'
  worker.on 'online', ->
  	console.log 'event online'
  	setTimeout ->
  		worker.send('hi there');
  	, 500
  worker.on 'listening', -> console.log 'event listening'
  worker.on 'disconnect', -> console.log 'event disconnect'
  worker.on 'exit', -> console.log 'event exit'
  worker.on 'setup', -> console.log 'event setup'


else if (cluster.isWorker)
  process.on 'message', -> console.log 'WORKER event message', arguments
  process.on 'online', -> console.log 'WORKER event online'
  process.on 'listening', -> console.log 'WORKER event listening'
  process.on 'disconnect', -> console.log 'WORKER event disconnect'
  process.on 'exit', -> console.log 'WORKER event exit'
  process.on 'error', -> console.log 'WORKER event error'
###