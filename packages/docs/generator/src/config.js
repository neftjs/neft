const path = require('path')

const PUBLIC = path.dirname(require.resolve('@neft/docs-public'))
const EDITOR_VIEW_APP = path.join(path.dirname(require.resolve('@neft/docs-editor-view-app')), '../')
const EDITOR = path.join(path.dirname(require.resolve('@neft/docs-editor')), '../')

exports.STYLE = {
  in: path.join(PUBLIC, 'styles/main.less'),
  out: 'gh-pages/styles/main.css',
}
exports.COPY = [
  { in: 'media', out: 'gh-pages' },
  { cwd: PUBLIC, in: 'styles/**/*.css', out: 'gh-pages' },
  { cwd: PUBLIC, in: 'scripts', out: 'gh-pages' },
  { cwd: path.join(EDITOR_VIEW_APP, 'dist/html'), in: 'bundle.js', out: 'gh-pages/editor-view-app' },
  { cwd: PUBLIC, in: 'editor-view-app', out: 'gh-pages' },
  { cwd: path.join(EDITOR, 'dist'), in: 'index.js', out: 'gh-pages/scripts/neft-editor.js' },
]
exports.HTML_PARTIALS = path.join(PUBLIC, '/partials/*.html')
exports.HTML_FILES = {
  cwd: PUBLIC,
  in: '*.html',
  out: 'gh-pages',
}
exports.API_FILES = 'packages/**/*.doc.xml'
exports.SEARCH_FILE = 'gh-pages/scripts/search-texts.js'
