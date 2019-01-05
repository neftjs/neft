const glob = require('glob')
const fs = require('fs').promises
const querystring = require('querystring')
const { promisify } = require('util')
const stringify = require('../stringify')
const { parseDocFile } = require('../parser')
const { API_FILES } = require('../config')

const TOC_TYPES = [
  { type: 'property', title: 'Properties' },
  { type: 'signal', title: 'Signals' },
  { type: 'method', title: 'Methods' },
]

const BODY_TYPES = [
  { type: 'property', title: 'Property Documentation' },
  { type: 'signal', title: 'Signal Documentation' },
  { type: 'method', title: 'Method Documentation' },
]

const KNOWN_TYPES_IN_BODY = new Set(BODY_TYPES.map(({ type }) => type))

function getFullBlockName({ props }, parents) {
  return parents.map(({ props: subprops }) => subprops.name)
    .concat([props.name])
    .join('.')
}

function getTypeLink(aside, type) {
  const uri = aside.types[type]
  if (uri) return `<a href="${uri}">${type}</a>`
  if (type[0].toUpperCase() === type[0]) console.warn(`Cannot find type ${type}`)
  return type
}

function getTypeHeader({ type, props, content }, { aside, linkTypes = false, parents = [] } = {}) {
  let html = ''
  const name = getFullBlockName({ props }, parents)
  switch (type) {
    case 'property':
      html += `<b>${name}</b> : `
      html += linkTypes ? getTypeLink(aside, props.type) : props.type
      break
    case 'signal':
      html += `<b>${name}</b>`
      break
    case 'method': {
      const argPropsToText = argProps => `<i>${argProps.name}</i> : ${argProps.type}`
      const args = content
        .filter(({ type: childType }) => childType === 'argument')
        .map(({ props: childProps, content: childContent }) => {
          if (childContent.length) {
            const subargs = childContent.map(subarg => argPropsToText(subarg.props))
            return `{ ${subargs.join(', ')} }`
          }
          return argPropsToText(childProps)
        })
      html += `<b>${name}</b>(${args.join(', ')})`
      if (props.returns != null) {
        html += ` : ${linkTypes ? getTypeLink(aside, props.returns) : props.returns}`
      }
      break
    }
    default:
      throw new Error(`Unknown ${type}`)
  }
  return html
}

function stringToUri(string) {
  return querystring.escape(string.replace(/ /g, '-'))
}

function getTypeAnchor(type, parents) {
  return stringToUri(getFullBlockName(type, parents))
}

function stringifyBlock({ type, props }, innerHTML, parents) {
  switch (type) {
    case 'text':
      return `<p>${props.body}</p>`
    case 'script':
      return stringify.script(props) + innerHTML
    case 'argument':
      return ''
    case 'article': {
      const level = parents
        .filter(block => block.type === 'article')
        .length + 2
      return `<h${level}>${props.title}</h${level}>${innerHTML}`
    }
    default:
      throw new Error(`Unknown block with type ${type} and props ${Object.keys(props)}`)
  }
}

function generateHtmlToc(content, { headers = true, parents = [] } = {}) {
  const contentByType = {}
  let html = ''

  content.forEach((block) => {
    const { type } = block
    contentByType[type] = contentByType[type] || []
    contentByType[type].push(block)
  })

  TOC_TYPES.forEach(({ type, title }) => {
    const blocks = contentByType[type]
    if (!blocks) return
    if (headers) html += `<h2>${title}</h2>`
    html += '<ul>'
    blocks.forEach((block) => {
      html += '<li>'
      html += `<a href="#${getTypeAnchor(block, parents)}">`
      html += `<span class="name">${getTypeHeader(block, { parents })}</span>`
      html += '</a>'
      html += generateHtmlToc(block.content, {
        headers: false,
        parents: [...parents, block],
      })
      html += '</li>'
    })
    html += '</ul>'
  })

  return html
}

function generateHtmlBody(content, { aside, headers = true, parents = [] } = {}) {
  const contentByType = {}
  const rest = []
  let html = ''

  content.forEach((block) => {
    const { type } = block
    if (KNOWN_TYPES_IN_BODY.has(type)) {
      contentByType[type] = contentByType[type] || []
      contentByType[type].push(block)
    } else {
      rest.push(block)
    }
  })

  rest.forEach((block) => {
    const innerHTML = generateHtmlBody(block.content, {
      aside, headers, parents: [...parents, block],
    })
    html += stringifyBlock(block, innerHTML, parents)
  })

  BODY_TYPES.forEach(({ type, title }) => {
    const types = contentByType[type]
    if (!types) return
    if (headers) html += `<h2>${title}</h2>`
    types.forEach((block) => {
      html += `<a name="${getTypeAnchor(block, parents)}"></a>`
      html += `<h3>${getTypeHeader(block, { aside, linkTypes: true, parents })}</h3>`
      html += generateHtmlBody(block.content, {
        aside, headers: false, parents: [...parents, block],
      })
    })
  })

  return html
}

function getFileUri({ meta }) {
  const parts = ['/api', meta.category, meta.name].filter(part => !!part)
  return parts.join('/').toLowerCase()
}

function generateHtmlHead({ meta }, { aside }) {
  let html = `<h1>${meta.title || meta.name}</h1>`
  if (meta.extends) {
    html += `<p>Extends: ${getTypeLink(aside, meta.extends)}</p>`
  }
  return html
}

function generateHtmlFile(elements, { aside }) {
  const { content } = elements
  let html = ''

  html += generateHtmlHead(elements, { aside })
  html += generateHtmlToc(content)
  html += generateHtmlBody(content, { aside })

  return {
    uri: getFileUri(elements),
    template: `
{{> head}}
{{> navbar}}
<div class="main">
  <main class="content api">
    ${html}
  </main>
  <aside id="aside">
    ${aside.html}
  </aside>
</div>
{{> footer}}
    `,
    view: {},
  }
}

function generateAside(files) {
  const categories = {}
  const types = {}

  files.forEach(({ meta }) => {
    const uri = getFileUri({ meta })
    categories[meta.category] = categories[meta.category] || []
    categories[meta.category].push({ title: meta.title || meta.name, uri })
    types[[meta.category, meta.name].join('.')] = uri
  })

  let html = '<ul>'
  Object.keys(categories).sort().forEach((category) => {
    html += `<li><span class="category">${category}</span><ul>`
    html += categories[category].map(({ title, uri }) => `<li><a href="${uri}">${title}</a></li>`).join('')
    html += '</ul></li>'
  })
  html += '</ul>'

  return { html, types }
}

exports.getPages = async () => {
  const pages = []
  const filenames = await promisify(glob)(API_FILES)
  const files = await Promise.all(filenames.map(async (filename) => {
    const file = await fs.readFile(filename, 'utf-8')
    try {
      return parseDocFile(file)
    } catch (error) {
      throw new Error(`Cannot parse ${filename}: ${error}`)
    }
  }))
  const aside = generateAside(files)
  await Promise.all(files.map(async (elements) => {
    pages.push(generateHtmlFile(elements, { aside }))
  }))
  return pages
}
