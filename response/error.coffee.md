Networking.Response.Error
=========================

	'use strict'

	utils = require 'utils'
	assert = require 'assert'

	assert = assert.scope 'Networking.Response.Error'

	module.exports = (Networking, Response) -> class ResponseError extends Error

		@RequestResolve = RequestResolve Networking, Response, ResponseError

*Error* Error(*Integer* status, *String* message)
-------------------------------------------------

This class is used in the `Networking.Response::raise()` method and describes an error.

It works as standard Javascript `Error` class, but provides extra `status` value.

		constructor: (status, message='') ->
			unless @ instanceof ResponseError
				return new ResponseError status, message

			if typeof status is 'string'
				message = status
				status = @status

			assert.ok utils.has(Response.STATUSES, status)
			assert.isString message

			@status = status
			@message = message

		status: Response.INTERNAL_SERVER_ERROR
		name: 'ResponseError'
		message: ''

*RequestResolve* Error.RequestResolve(*Networking.Request* request)
-------------------------------------------------------------------

This error is send if the request can't be resolved, because no proper handler which can
handle the request can be found.

	RequestResolve = (Networking, Response, ResponseError) -> class RequestResolve extends ResponseError

		constructor: (req) ->
			assert.instanceOf req, Networking.Request, 'ctor request argument ...'

			return super "No handler can be found"

		status: Response.BAD_REQUEST
		name: 'RequestResolveResponseError'
