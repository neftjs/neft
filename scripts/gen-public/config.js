exports.STYLE = {
  in: 'public/styles/main.less',
  out: 'gh-pages/styles/main.css',
}
exports.COPY = [
  { in: 'media', out: 'gh-pages' },
  { cwd: 'public', in: 'styles/**/*.css', out: 'gh-pages' },
  { cwd: 'public', in: 'scripts', out: 'gh-pages' },
]
exports.HTML_PARTIALS = 'public/partials/*.html'
exports.HTML_FILES = {
  cwd: 'public',
  in: '*.html',
  out: 'gh-pages',
}
exports.API_FILES = 'packages/**/*.doc.xml'

// exports.OUTPUT_DIR = 'gh-pages'
// exports.PUBLIC_DIR = 'public'
// exports.PATHS_TO_COPY = ['media', 'public/styles/**/*.css', 'public/scripts']
// exports.GUIDE_FILES = 'docs/guide/**/*.md'
// exports.STYLES_DIR = 'public/styles/'
// exports.MAIN_STYLE = 'main.less'
// exports.INDEX_PAGE = 'public/index.mustache'
// exports.DOCS_PAGE = 'public/docs.mustache'
// exports.API_PAGE = 'public/api.mustache'
// exports.EXAMPLES_PAGE = 'public/examples.mustache'
// exports.API_SUMMARY_PATH = 'public/api/SUMMARY.json'
// exports.LANG_ALIASES = { nml: 'qml' }
// exports.IGNORED_LANGS = { svg: true }
// exports.SEARCH_FILE = 'scripts/search-texts.js'
