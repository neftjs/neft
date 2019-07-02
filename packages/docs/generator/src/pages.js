const api = require('./pages/api')
const docs = require('./pages/docs')
const examples = require('./pages/examples')

exports.getPages = async () => {
  const [apiPages, docsPages, examplesPages] = await Promise.all([
    api.getPages(),
    docs.getPages(),
    examples.getPages(),
  ])
  return apiPages.concat(docsPages).concat(examplesPages)
}
