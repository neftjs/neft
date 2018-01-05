'use strict'

marker = require './marker'

delimeterRegexp = (start, end = start, prefix = '', suffix = '') ->
    new RegExp "(#{prefix})#{start}(.+?)#{end}(#{suffix})", 'g'

RULES = [
    {
        regexp: delimeterRegexp '__', '__', ' |^', ' |$'
        replacer: marker.bold
    },
    {
        regexp: delimeterRegexp '\\*\\*'
        replacer: marker.bold
    },
    {
        regexp: delimeterRegexp '_', '_', ' |^', ' |$'
        replacer: marker.italic
    },
    {
        regexp: delimeterRegexp '\\*'
        replacer: marker.italic
    },
    {
        regexp: delimeterRegexp '~~'
        replacer: marker.strikethrough
    },
    {
        regexp: delimeterRegexp '<u>', '<\\/u>'
        replacer: marker.underline
    },
    {
        regexp: delimeterRegexp '`'
        replacer: marker.code
    },
]

exports.parse = (msg, context) ->
    msg = String(msg)
    for rule in RULES
        msg = msg.replace rule.regexp, (_, prefix, str, suffix) ->
            prefix + rule.replacer(str, context) + suffix
    msg

exports.clear = (msg) ->
    for rule in RULES
        msg = msg.replace rule.regexp, '$1$2$3'
    msg
