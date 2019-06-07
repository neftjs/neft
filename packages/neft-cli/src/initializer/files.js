exports['./src/index.js'] = `import Neft from '@neft/core'

const render = () => {
  Neft.render(require('./components/App').default, { context: null })
}

if (module.hot) {
  module.hot.accept('./components/App', render)
}

render()
`

exports['./src/components/App/App.xhtml'] = `Hello World!
`

exports['./src/components/App/index.js'] = `export { default } from './App'
`
