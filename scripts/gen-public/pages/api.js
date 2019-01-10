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
  return type.replace(/[A-Za-z.0-9]+/, (justType) => {
    const uri = aside.types[justType]
    if (uri) return `<a href="${uri}">${justType}</a>`
    if (justType[0].toUpperCase() === justType[0]) console.warn(`Cannot find type ${justType}`)
    return justType
  })
}

function getTypeHeader({ type, props, content }, {
  aside,
  linkTypes = false,
  parents = [],
  mapName = name => `<b>${name}</b>`,
} = {}) {
  let html = ''
  const name = getFullBlockName({ props }, parents)
  switch (type) {
    case 'property':
      html += `${mapName(name)} : `
      html += linkTypes ? getTypeLink(aside, props.type) : props.type
      break
    case 'signal':
      html += mapName(name)
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
      html += `${mapName(name)}(${args.join(', ')})`
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
  return string
    .replace(/ /g, '-')
    .replace(/\./g, '/')
    .split('/')
    .map(querystring.escape)
    .join('/')
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
  const names = {}
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
    html += '<ul class="toc">'
    blocks.forEach((block) => {
      const header = getTypeHeader(block, {
        parents,
        mapName: name => `<a href="#${getTypeAnchor(block, parents)}"><b>${name}</b></a>`,
      })
      if (names[header]) throw new Error(`Duplicated name for ${header}`)
      names[header] = true
      html += '<li>'
      html += `<span class="name">${header}</span>`
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

function getFileTitleSteps({ meta }) {
  const categories = meta.category.split('/')
  const names = meta.name.split('.')
  return [categories[0], ...names.slice(0, -1), ...categories.slice(1), ...names.slice(-1)]
}

function getFileUri({ meta }) {
  const parts = getFileTitleSteps({ meta }).map(stringToUri)
  return `/${parts.join('/').toLowerCase()}`
}

function generateHtmlHead({ meta }, { aside }) {
  let html = `<h1>${meta.title || meta.name}</h1>`
  if (meta.extends) {
    html += `<p>Extends: ${getTypeLink(aside, meta.extends)}</p>`
  }
  return html
}

function generateAside(inputFiles, { activeUri }) {
  const types = {}
  const uris = {}
  const files = inputFiles.slice()

  // sort files
  const filePriority = ({ elements }) => {
    let priority = getFileTitleSteps(elements).length * 100
    if (!elements.meta.extends) priority -= 1
    return priority
  }
  files.sort((a, b) => filePriority(a) - filePriority(b))

  // build types and uris
  files.forEach(({ filename, elements: { meta } }) => {
    const uri = getFileUri({ meta })
    if (uris[uri]) throw new Error(`Duplicated uri for ${uri} comes from ${filename} and ${uris[uri]}`)
    if (types[meta.name]) throw new Error(`Duplicated name for ${meta.name} comes from ${filename}`)
    uris[uri] = filename
    types[meta.name] = uri
  })

  // build tree
  const tree = {}
  files.forEach(({ elements: { meta } }) => {
    const steps = getFileTitleSteps({ meta })
    const lastStep = steps.reduce((target, step) => {
      target[step] = target[step] || {}
      return target[step]
    }, tree)
    lastStep.uri = types[meta.name]
  })

  // generate html
  const uriToHtml = (uri, title) => {
    const linkClass = uri === activeUri ? ' class="active"' : ''
    return `<a href="${uri}"${linkClass}>${title}</a>`
  }
  const leafToHtml = (leaf) => {
    let html = '<ul>'
    let active = false
    Object.entries(leaf).forEach(([category, subleaf]) => {
      html += '<li>'
      if (subleaf.uri) {
        active = active || subleaf.uri === activeUri
        html += uriToHtml(subleaf.uri, category)
      } else {
        const { html: subleafHtml, active: subleafActive } = leafToHtml(subleaf)
        active = active || subleafActive
        const categoryClass = ['category']
        if (active) categoryClass.push('active')
        html += `<span class="${categoryClass.join(' ')}">${category}</span>`
        html += subleafHtml
      }
      html += '</li>'
    })
    html += '</ul>'
    return { html, active }
  }

  return { types, html: leafToHtml(tree).html }
}

function generateHtmlFile(elements, { files }) {
  const { content } = elements
  let html = ''

  const aside = generateAside(files, { activeUri: getFileUri(elements) })
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

exports.getPages = async () => {
  const pages = []
  const filenames = await promisify(glob)(API_FILES, { ignore: '**/node_modules/**' })
  const files = await Promise.all(filenames.map(async (filename) => {
    const file = await fs.readFile(filename, 'utf-8')
    try {
      return { filename, elements: parseDocFile(file) }
    } catch (error) {
      throw new Error(`Cannot parse ${filename}: ${error}`)
    }
  }))
  await Promise.all(files.map(async ({ filename, elements }) => {
    try {
      pages.push(generateHtmlFile(elements, { files }))
    } catch (error) {
      throw new Error(`Cannot generate HTML file for ${filename}: ${error}`)
    }
  }))
  return pages
}
