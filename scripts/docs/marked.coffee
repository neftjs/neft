marked = require 'marked'
highlightJs = require 'highlight.js'
{LANG_ALIASES, IGNORED_LANGS} = require './config'

marked.setOptions
    langPrefix: 'hljs '
    highlight: (code, lang) ->
        lang = LANG_ALIASES[lang] or lang
        if lang and not IGNORED_LANGS[lang]
            highlightJs.highlight(lang, code).value
        else
            code

class Renderer extends marked.Renderer
    constructor: (@page) ->

    heading: (text, level, mdText) ->
        cleanText = mdText.replace(/\*|`/g, '')
        cleanText = cleanText.replace(/\[([^\]]+)\]\([^\)]+\)/g, '$1') # remove md links

        exports.headings.push
            page: @page
            level: level
            text: cleanText
        super arguments...

exports.headings = []

exports.toHTML = (markdown, name) ->
    marked markdown, renderer: new Renderer(name)
