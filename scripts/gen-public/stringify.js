const highlight = require('highlight.js')

exports.script = ({ lang, body }) => {
  let language = lang
  if (language === 'nml') language = 'qml'
  if (language === 'svg') language = 'xml'
  const code = highlight.highlight(language, body).value
  return `<pre>${code}</pre>`
}
