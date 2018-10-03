const fs = require('fs')
const path = require('path')
const webpack = require('webpack')
const HardSourceWebpackPlugin = require('hard-source-webpack-plugin')
const util = require('@neft/core/src/util')
const { produceManifest } = require('./manifest')
const { generateIcons } = require('./icon')
const {
  realpath, outputDir, packageFile, targets, targetEnvs,
} = require('../config')

const targetBuilders = {
  html: require('./browser'),
  webgl: require('./browser'),
  android: require('./android'),
}
const webpackStatsToString = {
  chunks: false,
  modules: false,
  version: false,
  assets: false,
  builtAt: false,
  children: false,
  colors: true,
  hash: false,
}

const getDefaultStyles = () => Object.keys(packageFile.dependencies || {})
  .filter(name => name.startsWith('@neft/'))
  .filter(name => fs.existsSync(path.join('node_modules/', name, '/index.nml')))

const getDefines = (production, target) => {
  const defines = {
    'process.env.NODE_ENV': JSON.stringify(production ? 'production' : 'development'),
    'process.env.NEFT_PLATFORM': JSON.stringify(target),
  }
  Object.keys(targets).forEach((possibleTarget) => {
    const enabled = possibleTarget === target
    const val = JSON.stringify(enabled ? '1' : '')
    Object.keys(targetEnvs[possibleTarget]).forEach((env) => {
      const fullEnv = `NEFT_${env.toUpperCase()}`
      const define = `process.env.${fullEnv}`
      if (define in defines && !enabled) return
      defines[define] = val
    })
  })
  return defines
}

const compile = compiler => new Promise((resolve, reject) => {
  compiler.run((err, stats) => {
    if (err) {
      let message = err.stack || err
      if (err.details) message += `\n${err.details}`
      reject(new Error(message))
    } else if (stats.hasErrors() || stats.hasWarnings()) {
      reject(new Error(stats.toString(webpackStatsToString)))
    } else {
      resolve()
    }
  })
})

const findExtensions = () => Object.keys(packageFile.dependencies)
  .filter(name => name.startsWith('@neft/'))
  .map(name => path.join(realpath, './node_modules', name))

exports.build = async (target, args) => {
  const targetBuilder = targetBuilders[target]
  const output = path.join(outputDir, target)
  const filepath = path.join(output, 'bundle.js')
  const production = !!args.production
  const extensions = findExtensions()
  const defaultWebpackConfig = {
    entry: [
      './src/index.js',
      require.resolve('webpack-hot-middleware/client'),
    ],
    output: {
      path: output,
      filename: 'bundle.js',
      publicPath: '/',
    },
    devtool: 'inline-source-map',
    devServer: {
      contentBase: './dist',
    },
    // devtool: false,
    target: 'node',
    mode: production ? 'production' : 'development',
    resolve: {
      extensions: ['.js', '.xhtml', '.html', '.coffee', '.litcoffee'],
    },
    plugins: [
      new webpack.HotModuleReplacementPlugin(),
      new webpack.DefinePlugin(getDefines(production, target)),
      new HardSourceWebpackPlugin({ info: { mode: 'none', level: 'error' } }),
    ],
    module: {
      rules: [
        {
          test: /\.(xhtml|html|nml)$/,
          loader: require.resolve('@neft/webpack-loader'),
          options: {
            defaultStyles: getDefaultStyles(),
          },
        },
        {
          test: /\.(coffee|coffee\.md|litcoffee)$/,
          use: [require.resolve('./webpack-coffee-loader')],
        },
        {
          test: /\.js$/,
          exclude: /(node_modules)/,
          use: {
            loader: require.resolve('babel-loader'),
            options: {
              presets: [require.resolve('@babel/preset-env')],
            },
          },
        },
      ],
    },
  }
  const webpackConfig = util.mergeDeepAll(defaultWebpackConfig, targetBuilder.webpackConfig)
  const compiler = webpack(webpackConfig)

  const Express = require('express')
  const webpackDevMiddleware = require('webpack-dev-middleware')
  const app = new Express()
  app.use(webpackDevMiddleware(compiler, {
    // noInfo: true,
    publicPath: webpackConfig.output.publicPath,
  }))
  app.use(require("webpack-hot-middleware")(compiler))
  app.listen(3001, (err) => {
    console.log('LISTEN', err)
  })

  // compiler.watch({
  //   watch: true,
  //   watchOptions: {
  //     ignored: /node_modules/,
  //   },
  // }, (err, stats) => {
  //   console.log(err, stats.toJson(webpackStatsToString))
  // })

  // await compile(compiler)
  // const manifest = await produceManifest({ ...targetBuilder, target, output })
  // await generateIcons({ ...targetBuilder, target, manifest })
  // await targetBuilder.build({
  //   manifest, output, filepath, production, extensions,
  // })
}
