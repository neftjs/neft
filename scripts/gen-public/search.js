let DOCS_DIR; let OUTPUT_DIR; let SEARCH_FILE; let file; let fs; let heading; let i; let json; let jsonPages; let jsonTexts; let lastPageId; let len; let marked; let pageId; let pages; let path; let pathUtils; let ref; let
  text

pathUtils = require('path')

fs = require('fs-extra')

marked = require('./marked');

({ OUTPUT_DIR, DOCS_DIR, SEARCH_FILE } = require('./config'))

json = {
  pages: jsonPages = [],
  texts: jsonTexts = [],
}

pages = {}

lastPageId = 0

ref = marked.headings
for (i = 0, len = ref.length; i < len; i++) {
  heading = ref[i]
  pageId = pages[heading.page]
  if (pageId === void 0) {
    jsonPages.push(heading.page)
    pageId = jsonPages.length - 1
    pages[heading.page] = pageId
  }
  text = [pageId, heading.level, heading.text]
  jsonTexts.push(text)
}

path = pathUtils.join(OUTPUT_DIR, DOCS_DIR, SEARCH_FILE)

file = `var searchTexts = ${JSON.stringify(json)}`

fs.outputFileSync(path, file)
