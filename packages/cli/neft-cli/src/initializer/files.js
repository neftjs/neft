exports['./src/index.js'] = `import Neft from '@neft/core'
import App from './components/App'

Neft.render(App)
`

exports['./src/components/App/App.html'] = `Hello World!
`

exports['./src/components/App/index.js'] = `export { default } from './App'
`
