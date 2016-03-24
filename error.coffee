'use strict'

ERROR_STACK_MAX_LENGTH = 500

exports.toString = (err) ->
	msg = ''
	if err.stack
		specFileLine = /^.+\.spec\.[a-z]+:\d+:\d+$/m.exec err.stack
		if specFileLine?
			msg += specFileLine[0] + "\n\n"
		if err.stack.length > ERROR_STACK_MAX_LENGTH
			msg += "#{err.stack.slice(0, ERROR_STACK_MAX_LENGTH)}…"
		else
			msg += err.stack
	else
		msg += err
	msg += "\n"
	msg
