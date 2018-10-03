exports.webpackConfig = {}

exports.defaultManifest = {
  package: 'io.neft.example.app',
  label: 'Neft.io App',
}

exports.icons = [
  { width: 58, height: 58, out: 'iphone-29@2x.png' },
  { width: 87, height: 87, out: 'iphone-29@3x.png' },
  { width: 80, height: 80, out: 'iphone-40@2x.png' },
  { width: 120, height: 120, out: 'iphone-40@3x.png' },
  { width: 120, height: 120, out: 'iphone-60@2x.png' },
  { width: 180, height: 180, out: 'iphone-60@3x.png' },
  { width: 29, height: 29, out: 'ipad-29.png' },
  { width: 58, height: 58, out: 'ipad-29@2x.png' },
  { width: 40, height: 40, out: 'ipad-40.png' },
  { width: 80, height: 80, out: 'ipad-40@2x.png' },
  { width: 76, height: 76, out: 'ipad-76.png' },
  { width: 152, height: 152, out: 'ipad-76@2x.png' },
  { width: 167, height: 167, out: 'ipad-83p5@2x.png' },
  { width: 1024, height: 1024, out: 'default.png' },
]

exports.build = () => {}
