const highlight = require('highlight.js')

exports.script = ({ lang, body }, { tag = 'pre' } = {}) => {
  let language = lang
  if (language === 'nml') language = 'qml'
  if (language === 'svg') language = 'xml'
  const code = language
    ? highlight.highlight(language, body).value
    : highlight.highlightAuto(body).value
  return `<${tag} class="hljs">${code}</${tag}>`
}
