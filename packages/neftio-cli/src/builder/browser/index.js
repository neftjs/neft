const HtmlWebpackPlugin = require('html-webpack-plugin')
const { packageConfig } = require('../../config')

const defaultTitle = 'Neft.io app'

exports.webpackConfig = {
  plugins: [
    new HtmlWebpackPlugin({
      title: packageConfig.title || defaultTitle,
    }),
  ],
}

exports.build = () => {}
