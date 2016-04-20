'use strict'

exports.toString = (err) ->
	msg = ''
	if err.stack
		specFileLine = /^.+\.spec\.[a-z]+:\d+:\d+$/m.exec err.stack
		if specFileLine?
			msg += specFileLine[0] + "\n\n"
		msg += err.stack
	else
		msg += err
	msg += "\n"
	msg
