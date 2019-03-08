const Mustache = require('mustache')
const fs = require('fs-extra')
const glob = require('glob')
const path = require('path')
const { promisify } = require('util')
const pages = require('./pages')
const { HTML_PARTIALS, HTML_FILES } = require('./config')

const partials = {}

async function preparePartials() {
  const filenames = await promisify(glob)(HTML_PARTIALS)
  await Promise.all(filenames.map(async (filename) => {
    const name = path.basename(filename, '.html')
    const file = await fs.readFile(filename, 'utf-8')
    Mustache.parse(file)
    partials[name] = file
  }))
}

function getViewObject(uri, view) {
  const getClassName = ({ uri: linkUri }) => {
    if (uri.startsWith(linkUri)) return 'active'
    return ''
  }
  return {
    ...view,
    nav: [
      // { title: 'Playground', uri: '', className: '' },
      { title: 'Docs', uri: '', className: '' },
      {
        title: 'Modules',
        uri: '/modules/activelink',
        className: getClassName({ uri: '/modules/' }),
      },
      {
        title: 'API Reference',
        uri: '/api-reference/neft',
        className: getClassName({ uri: '/api-reference/' }),
      },
    ],
  }
}

async function compileFile(file, view, uri) {
  const html = Mustache.render(file, getViewObject(uri, view), partials)
  const out = `${uri}.html`
  await fs.outputFile(path.join(HTML_FILES.out, out), html)
}

async function compilePublicFiles() {
  const filenames = await promisify(glob)(HTML_FILES.in, {
    cwd: path.join(process.cwd(), HTML_FILES.cwd),
  })
  await Promise.all(filenames.map(async (filename) => {
    const file = await fs.readFile(path.join(HTML_FILES.cwd, filename), 'utf-8')
    await compileFile(file, null, path.basename(filename, '.html'))
  }))
}

module.exports = async () => {
  await preparePartials()
  await compilePublicFiles()

  const pagesList = await pages.getPages()
  await Promise.all(pagesList.map(async (page) => {
    await compileFile(page.template, page.view, page.uri)
  }))
}
