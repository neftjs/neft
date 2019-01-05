const { parse } = require('lite-html-parser')

class Element {
  constructor(name = '') {
    this.name = name
    this.children = []
    this.props = {}
  }
}

function parseXmlToElements(xml) {
  const stack = [new Element()]
  const last = () => stack[stack.length - 1]

  parse(xml, {
    opentag(name) {
      const elem = new Element(name)
      last().children.push(elem)
      stack.push(elem)
    },
    closetag(name) {
      if (name !== '' && last().name !== name) {
        throw new Error(`Expected ${last().name} to be closed but found ${name}`)
      }
      stack.pop()
    },
    attribute(name, value) {
      last().props[name] = value
    },
    text(text) {
      const lines = text.split('\n')
      while (lines.length && !lines[0].trim()) lines.shift()
      if (!lines.length) return
      const indentation = lines[0].length - lines[0].trimLeft().length
      const textTrim = lines
        .map(line => line.slice(indentation))
        .join('\n')
      const elem = new Element('text')
      elem.props.body = textTrim
      last().children.push(elem)
    },
    comment(comment) {
      const elem = new Element('comment')
      elem.props.body = comment
      last().children.push(elem)
    },
    instruction(instruction) {
      const elem = new Element('instruction')
      elem.props.body = instruction
      last().children.push(elem)
    },
  }, {
    noAttributeValue: true,
  })

  return stack[0].children
}

const anyHandler = (type, props, target) => {
  const script = Object.seal({ type, props, content: [] })
  target.content.push(script)
  return script
}

const handlers = {
  meta(props, target) {
    target.meta = props
  },
  text(props, target) {
    if (target.type === 'script') {
      target.props.body = props.body
      return target
    }
    return anyHandler('text', props, target)
  },
}

function handleElement({ name, props, children }, target) {
  const result = handlers[name] ? handlers[name](props, target) : anyHandler(name, props, target)
  handleElements(children, result)
}

function handleElements(elements, target) {
  elements.forEach(((element) => {
    handleElement(element, target)
  }))
}

exports.parseDocFile = (file) => {
  const doc = Object.seal({ meta: null, content: [] })
  const elements = parseXmlToElements(file)
  handleElements(elements, doc)
  return doc
}
