const highlight = require('highlight.js')

exports.script = ({ lang, body, interactive }, { tag = 'pre' } = {}) => {
  if (interactive) {
    return `
      <div class="editor">
        <div class="code">
          <textarea readonly>${body}</textarea>
        </div>
        <div class="preview">
          <header>
            <span class="key"></span>
            <ul class="badges">
              <li><img src="/media/badges/app-store.svg"></li>
              <li><img src="/media/badges/google-play.svg"></li>
            </ul>
          </header>
          <iframe src="/editor-view-app"></iframe>
        </div>
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
