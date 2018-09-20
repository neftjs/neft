exports['./src/index.js'] = `
import Neft from '@neft/core'
import App from './components/App'

const app = App()
app.render({ context: null })
Neft.attach(app)
`

exports['./src/components/App/App.xhtml'] = `
Hello World!
`

exports['./src/components/App/index.js'] = `
export { default } from './App'
`
