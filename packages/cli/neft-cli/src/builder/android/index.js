const { build } = require('./builder')

exports.shouldLoadStaticFiles = true

exports.shouldBundle = true

exports.shouldProduceManifest = true

exports.shouldGenerateIcons = true

exports.defaultManifest = {
  package: 'io.neft.example.app',
  versionCode: 1,
  versionName: '1.0',
  label: 'Neft.io App',
  compileSdkVersion: 28,
  targetSdkVersion: 28,
  minSdkVersion: 20,
  buildToolsVersion: '28.0.3',
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
