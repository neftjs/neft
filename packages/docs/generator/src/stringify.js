const highlight = require('highlight.js')

exports.script = ({ lang, body, interactive }, { tag = 'pre' } = {}) => {
  if (interactive) {
    return `
      <div class="editor">
        <div class="code">
          <textarea readonly>${body}</textarea>
        </div>
        <iframe src="/editor-view-app"></iframe>
      </div>`
  }

  let language = lang
  if (language === 'neft') language = 'xml'
  if (language === 'nml') language = 'qml'
  if (language === 'svg') language = 'xml'
  const code = language
    ? highlight.highlight(language, body).value
    : highlight.highlightAuto(body).value
  return `<${tag} class="hljs">${code}</${tag}>`
}
