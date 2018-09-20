pathUtils = require 'path'
fs = require 'fs-extra'
marked = require './marked'
{OUTPUT_DIR, DOCS_DIR, SEARCH_FILE} = require './config'

json =
    pages: jsonPages = []
    texts: jsonTexts = []
pages = {}
lastPageId = 0

for heading in marked.headings
    pageId = pages[heading.page]
    if pageId is undefined
        jsonPages.push heading.page
        pageId = jsonPages.length - 1
        pages[heading.page] = pageId

    text = [pageId, heading.level, heading.text]
    jsonTexts.push text

path = pathUtils.join(OUTPUT_DIR, DOCS_DIR, SEARCH_FILE)
file = "var searchTexts = #{JSON.stringify(json)}"

fs.outputFileSync path, file
