const { build } = require('./builder')

exports.webpackConfig = {}

exports.defaultManifest = {
  package: 'com.example.app',
  versionCode: 1,
  versionName: '1.0',
  label: 'Neft.io App',
  compileSdkVersion: 25,
  targetSdkVersion: 25,
  buildToolsVersion: '25.0.0',
}

exports.icons = [
  { width: 36, height: 36, out: 'mipmap-ldpi/ic_launcher.png' },
  { width: 48, height: 48, out: 'mipmap-mdpi/ic_launcher.png' },
  { width: 72, height: 72, out: 'mipmap-hdpi/ic_launcher.png' },
  { width: 96, height: 96, out: 'mipmap-xhdpi/ic_launcher.png' },
  { width: 144, height: 144, out: 'mipmap-xxhdpi/ic_launcher.png' },
  { width: 192, height: 192, out: 'mipmap-xxxhdpi/ic_launcher.png' },
]

exports.build = build
