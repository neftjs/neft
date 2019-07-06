const fs = require('fs').promises
const path = require('path')
const yaml = require('js-yaml')
const glob = require('glob')
const { promisify } = require('util')
const stringify = require('../stringify')
const { EXAMPLES_FILES, EXAMPLES_NAV } = require('../config')

const getFilenameUri = (filename) => {
  const { name } = path.parse(filename)
  return `/examples/${encodeURIComponent(name)}`
}

const generateNav = (nav, { active }) => {
  const items = nav.map(({ title, file }) => {
    const uri = getFilenameUri(file)
    const linkClass = active === uri ? ' class="active"' : ''
    return `<li><a href="${uri}"${linkClass}>${title}</a></li>`
  })
  return `<ul>${items.join('')}</ul>`
}

const generateHtmlFile = async (filename, { nav }) => {
  const file = await fs.readFile(filename, 'utf-8')
  const uri = getFilenameUri(filename)
  const html = stringify.script({
    lang: 'neft',
    interactive: true,
    body: file,
  })

  return {
    uri,
    template: `
{{> head}}
{{> navbar}}
<div class="main">
<main class="content api">
  ${html}
</main>
<aside id="aside">
  ${generateNav(nav, { active: uri })}
</aside>
</div>
{{> footer}}
    `,
    view: {},
  }
}

exports.getPages = async () => {
  const filenames = await promisify(glob)(EXAMPLES_FILES)
  const nav = yaml.safeLoad(await fs.readFile(EXAMPLES_NAV, 'utf-8'))
  return Promise.all(filenames.map(filename => generateHtmlFile(filename, { nav })))
}
