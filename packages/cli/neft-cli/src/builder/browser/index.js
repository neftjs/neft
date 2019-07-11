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
    const possibleImports = [
      `${name}/lib/native/${target}`,
      `${name}/lib/native/browser`,
      `${name}/native/${target}`,
      `${name}/native/browser`,
    ]

    possibleImports.find((possibleImport) => {
      try {
        require.resolve(possibleImport)
        imports.push(possibleImport)
        return true
      } catch (error) {
        // NOP
      }
      return false
    })
  }))

  return imports
}

exports.build = async ({ output }) => {
  const indexHtml = path.join(output, '/index.html')
  await fs.writeFile(indexHtml, HTML)
}
