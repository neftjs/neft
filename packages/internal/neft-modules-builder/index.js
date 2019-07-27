const path = require('path')
const os = require('os')
const fs = require('fs-extra')
const babel = require('@babel/core')
const coffee = require('coffee-script')

const OUT = 'dist'

const IGNORED = new Set(['node_modules'])

const JS_PARSER = async ({ name, file }) => {
  const { code } = babel.transformSync(file, {
    presets: ['@babel/preset-env'],
  })
  return {
    file: code,
    name: `${name}.js`,
  }
}

const COFFEE_PARSER = async ({ name, ext, file }) => {
  const transpiled = coffee.compile(file, {
    literate: ext === '.litcoffee',
    sourceMap: false,
  })
  return {
    file: transpiled,
    name: `${name}.js`,
  }
}

const PARSERS = {
  '.js': JS_PARSER,
  '.coffee': COFFEE_PARSER,
  '.litcoffee': COFFEE_PARSER,
}

exports.build = async () => {
  // const realpath = await fs.realpath('.')
  const tmpOut = path.join(os.tmpdir(), `neft-module-dist-${String(Math.random()).slice(2)}`)

  await fs.remove(OUT)

  const filesToParse = []
  await fs.copy('.', tmpOut, {
    dereference: true,
    filter: (src, dest) => {
      if (IGNORED.has(src)) return false
      const { dir, ext, name } = path.parse(src)
      if (PARSERS[ext]) {
        filesToParse.push({
          ext, name, dir, src, dest,
        })
        return false
      }
      return true
    },
  })

  await Promise.all(filesToParse.map(async ({
    ext, name, dir, src, dest,
  }) => {
    const file = await fs.readFile(src, 'utf-8')
    const result = await PARSERS[ext]({
      ext, name, dir, src, file,
    })
    const newDest = path.join(path.dirname(dest), result.name)
    await fs.writeFile(newDest, result.file)
  }))

  await fs.move(tmpOut, OUT)
}
