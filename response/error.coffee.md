Routing.Response.Error
======================

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

	module.exports = (Routing, Response) -> class ResponseError extends Error

		@RequestResolve = RequestResolve Routing, Response, ResponseError

*Error* Error([*Integer* status], *String* message)
---------------------------------------------------

This class is used in the `Routing.Response::raise()` method and describes an error.

It works as standard Javascript `Error` class, but provides extra `status` value.

		constructor: (status, message='') ->
			unless @ instanceof ResponseError
				return new ResponseError status, message

			if typeof status is 'string'
				message = status
				status = @status

			expect().some(Response.STATUSES).toBe status
			expect(message).toBe.string()

			self.status = status
			self.message = message

		status: Response.INTERNAL_SERVER_ERROR
		name: 'ResponseError'
		message: ''

*RequestResolve* Error.RequestResolve(*Routing.Request* req)
------------------------------------------------------------

This error is send if the request can't be resolved, because no proper handler which can
handle the request can be found.

	RequestResolve = (Routing, Response, ResponseError) -> class RequestResolve extends ResponseError

		constructor: (req) ->
			expect(req).toBe.any Routing.Request

			return super "No handler can be found"

		status: Response.BAD_REQUEST
		name: 'RequestResolveResponseError'