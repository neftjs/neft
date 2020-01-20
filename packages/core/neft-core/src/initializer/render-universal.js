const Renderer = require('../renderer')
const Document = require('../document')
const Element = require('../document/element')
const eventLoop = require('../event-loop')

const createWindowDocument = (Content, options) => {
  const windowElement = new Element.Tag()
  windowElement.props.set('n-component', 'Content')
  windowElement.props.set('n-style', ['__default__', 'item'])

  const windowDocument = new Document('__window__', {
    style: {
      __default__: {
        item: () => {
          const item = Renderer.Item.New({ layout: 'flow' })
          return { objects: { item }, item }
        },
      },
    },
    styleItems: [{ element: [], children: [] }],
    imports: { Content },
    uses: [[]],
    element: windowElement,
  })

  windowDocument.render(options)
  Renderer.setWindowItem(windowElement.style)

  return windowDocument
}

let windowDocument
module.exports = (documentImport, options) => {
  eventLoop.setImmediate(() => {
    Document.register('__window__', null, { dependencies: [documentImport] })
    if (windowDocument) {
      if (windowDocument.rendered) windowDocument.revert()
      windowDocument.imports.Content = documentImport
      windowDocument.render(options)
    } else {
      windowDocument = createWindowDocument(documentImport, options)
    }
  })
}
