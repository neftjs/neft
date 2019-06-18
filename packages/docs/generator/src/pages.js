const api = require('./pages/api')

exports.getPages = async () => {
  const [apiPages] = await Promise.all([api.getPages()])
  return apiPages
}
