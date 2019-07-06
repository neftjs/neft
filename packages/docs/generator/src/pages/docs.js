const fs = require('fs').promises
const path = require('path')
const yaml = require('js-yaml')
const glob = require('glob')
const marked = require('marked')
const { promisify } = require('util')
const escape = require('escape-html')
const stringify = require('../stringify')
const { DOCS_FILES, DOCS_NAV } = require('../config')

class DocsMarkedRenderer extends marked.Renderer {
  heading(text, ...rest) {
    return super.heading(escape(text), ...rest)
  }

  code(code, infostring) {
    return stringify.script({
      lang: infostring,
      body: code,
      interactive: infostring === 'neft',
    })
  }
}

marked.setOptions({
  renderer: new DocsMarkedRenderer(),
})

const getFilenameUri = (filename) => {
  const { dir, name } = path.parse(filename)
  return `/${dir}/${encodeURIComponent(name)}`
}

const generateNav = (root, { active }) => {
  const generateSubNav = (nav) => {
    const items = nav.map(({ title, file, nav: subNav }) => {
      if (file) {
        const uri = getFilenameUri(path.join('docs', file))
        const linkClass = active === uri ? ' class="active"' : ''
        return `<li><a href="${uri}"${linkClass}>${title}</a></li>`
      }
      if (subNav) {
        return `<li><span class="category">${title}</span>${generateSubNav(subNav)}</li>`
      }
      return ''
    })
    return `<ul>${items.join('')}</ul>`
  }

  return generateSubNav(root)
}

const generateHtmlFile = async (filename, { nav }) => {
  const file = await fs.readFile(filename, 'utf-8')
  const uri = getFilenameUri(filename)
  const html = marked(file)

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
  const filenames = await promisify(glob)(DOCS_FILES)
  const nav = yaml.safeLoad(await fs.readFile(DOCS_NAV, 'utf-8'))
  return Promise.all(filenames.map(filename => generateHtmlFile(filename, { nav })))
}
