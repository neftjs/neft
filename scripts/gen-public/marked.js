let IGNORED_LANGS; let LANG_ALIASES; let Renderer; let highlightJs; let
  marked

marked = require('marked')

highlightJs = require('highlight.js');

({ LANG_ALIASES, IGNORED_LANGS } = require('./config'))

marked.setOptions({
  langPrefix: 'hljs ',
  highlight(code, lang) {
    lang = LANG_ALIASES[lang] || lang
    if (lang && !IGNORED_LANGS[lang]) {
      return highlightJs.highlight(lang, code).value
    }
    return code
  },
})

Renderer = class Renderer extends marked.Renderer {
  constructor(page) {
    super()
    this.page = page
  }

  heading(text, level, mdText) {
    let cleanText
    cleanText = mdText.replace(/\*|`/g, '')
    cleanText = cleanText.replace(/\[([^\]]+)\]\([^\)]+\)/g, '$1') // remove md links
    exports.headings.push({
      page: this.page,
      level,
      text: cleanText,
    })
    return super.heading(...arguments)
  }
}

exports.headings = []

exports.toHTML = function (markdown, name) {
  return marked(markdown, {
    renderer: new Renderer(name),
  })
}
