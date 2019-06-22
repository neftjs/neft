const path = require('path')
const fs = require('fs').promises
const { packageConfig, outputFile } = require('../../config')

const defaultTitle = 'Neft.io app'
const title = packageConfig.title || defaultTitle

const HTML = `<!doctype html>
<html>
<meta>
  <title>${title}</title>
</meta>
<body>
  <script src="/${outputFile}"></script>
</body>
</html>
`

exports.getImports = async ({ target, extensions }) => {
  const imports = []

  await Promise.all(extensions.map(async ({ name }) => {
    const indexTarget = `${name}/native/${target}`
    try {
      require.resolve(indexTarget)
      imports.push(indexTarget)
    } catch (error) {
      // NOP
    }

    const indexBrowser = `${name}/native/browser`
    try {
      require.resolve(indexBrowser)
      imports.push(indexBrowser)
    } catch (error) {
      // NOP
    }
  }))

  return imports
}

exports.build = async ({ output }) => {
  const indexHtml = path.join(output, '/index.html')
  await fs.writeFile(indexHtml, HTML)
}
