'use strict'

pathUtils = require 'path'
notifier = require 'node-notifier'

NOTIFY_ICON_PATH = pathUtils.join __dirname, '../../../media/logo-white.png'

module.exports = (err) ->
    notifier.notify
        title: 'Neft'
        icon: NOTIFY_ICON_PATH
        subtitle: if err then 'Build error' else ''
        message: if err then err.message?.split?('\n')[0] or err else 'Build ready'
