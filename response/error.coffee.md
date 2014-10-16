Response Error
==============

	'use strict'

	[utils] = ['utils'].map require

	{assert} = console

*class* RequestResolveResponseError
-----------------------------------

	RequestResolve = (Routing, Response, ResponseError) -> class RequestResolve extends ResponseError

		constructor: (req) ->

			assert req instanceof Routing.Request

			return super "No handler can be found", RequestResolve

		status: Response.BAD_REQUEST
		name: 'RequestResolveResponseError'

*class* ResponseError
---------------------

	module.exports = (Routing, Response) -> class ResponseError

		@RequestResolve = RequestResolve Routing, Response, ResponseError

		constructor: (message, Error) ->

			assert typeof message is 'string'

			self = @
			unless self instanceof ResponseError
				self = tmp

			if Error
				utils.merge self, Error::

			self.message = message

			return self

		status: Response.INTERNAL_SERVER_ERROR
		name: 'ResponseError'
		message: ''

		ResponseError:: = Object.create Error::

		tmp = Object.create ResponseError::