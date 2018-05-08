glob = require 'glob'
fs = require 'fs'
pathUtils = require 'path'
marked = require '../marked'

{GUIDE_PAGE, GUIDE_FILES} = require '../config'

exports = module.exports = []

pages = []
paths = glob.sync GUIDE_FILES
for path in paths
    file = fs.readFileSync path, 'utf-8'
    filename = pathUtils.parse(path).name
    order = parseInt /^([0-9]+)\-/.exec(filename)?[1] or NaN
    if order >= 0
        name = "guide/#{filename.slice(String(order).length + 1)}"
    else
        name = "guide/#{filename}"
    title = (/^#([^#\n]+)$/m.exec(file)?[1] or 'Unknown Title').trim()
    pages.push
        page: GUIDE_PAGE
        html: marked.toHTML file, name
        name: name
        title: title
        order: order

pages.sort (a, b) -> a.order - b.order

getNav = ->
    for page, i in pages
        name: page.name
        title: page.title

for page, i in pages
    page.nav = getNav()
    page.nav[i].active = true
    exports.push page
