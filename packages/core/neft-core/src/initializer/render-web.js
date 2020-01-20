/* global window */
const eventLoop = require('../event-loop')
const Document = require('../document')
const Element = require('../document/element')

const createWindowDocument = (Content, options) => {
  const windowElement = new Element.Tag()
  windowElement.props.set('n-component', 'Content')

  const windowDocument = new Document('__window__', {
    styleItems: [{ element: [], children: [] }],
    imports: { Content },
    uses: [[]],
    element: windowElement,
  })

  windowDocument.render(options)

  return windowDocument
}

module.exports = (documentImport, { element, ...options } = {}) => {
  eventLoop.setImmediate(() => {
    Document.register('__window__', null, { dependencies: [documentImport] })
    const windowDocument = createWindowDocument(documentImport, options)
    const renderToElement = element || window.document.body
    renderToElement.appendChild(windowDocument.element.element)
  })
}
