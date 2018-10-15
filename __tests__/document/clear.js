const { createView } = require('./utils')

describe('Document HTML file parse cleaner', () => {
  test('removes blank spaces and new lines from texts', () => {
    const view = createView('<span>\n    ABC\n</span>')
    view.render()
    const { text } = view.element.children[0].children[0]
    return assert.is(text, 'ABC')
  })

  test('does not removes white spaces from inline text', () => {
    const view = createView('<span> ABC </span>')
    view.render()
    const { text } = view.element.children[0].children[0]
    return assert.is(text, ' ABC ')
  })

  test('removes blank texts', () => {
    const view = createView('<span>\n</span>')
    view.render()
    return assert.is(view.element.children[0].children.length, 0)
  })
})
