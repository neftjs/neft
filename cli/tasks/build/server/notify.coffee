'use strict'

pathUtils = require 'path'
notifier = require 'node-notifier'

NOTIFY_ICON_PATH = pathUtils.join __dirname, '../../../media/logo-white.png'

module.exports = (err) ->
    notifier.notify
        title: 'Neft'
        icon: NOTIFY_ICON_PATH
        subtitle: if err then 'Error' else ''
        message: if err then err.name or err else 'Build ready'
