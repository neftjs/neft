const copy = require('./copy')
const html = require('./html')
const styles = require('./styles')
const search = require('./search')

const main = async () => {
  await Promise.all([styles(), html()])
  await copy()
  await search()
}

main().catch((error) => {
  console.error(error)
  process.exit(1)
})
