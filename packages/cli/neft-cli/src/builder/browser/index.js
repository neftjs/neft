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

exports.build = async ({ output }) => {
  const indexHtml = path.join(output, '/index.html')
  await fs.writeFile(indexHtml, HTML)
}
