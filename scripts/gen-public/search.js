const fs = require('fs-extra')
const { SEARCH_FILE } = require('./config')

const json = [
  ['API Reference', [
    ['api-reference/neft', '@neft/core', [
      ['Properties', [
        ['#width', 'width'],
        ['#height', 'height'],
      ]],
    ]],
  ]],
]

// const pages = {}

// ref = marked.headings
// for (i = 0, len = ref.length; i < len; i++) {
//   heading = ref[i]
//   pageId = pages[heading.page]
//   if (pageId === void 0) {
//     jsonPages.push(heading.page)
//     pageId = jsonPages.length - 1
//     pages[heading.page] = pageId
//   }
//   text = [pageId, heading.level, heading.text]
//   jsonTexts.push(text)
// }

module.exports = async () => {
  const file = `var searchTexts = ${JSON.stringify(json)}`
  await fs.outputFile(SEARCH_FILE, file)
}
