glob = require 'glob'
fs = require 'fs'
pathUtils = require 'path'
marked = require '../marked'

{API_PAGE, API_FILES, API_SUMMARY_PATH} = require '../config'

exports = module.exports = []

pages = []
paths = glob.sync API_FILES
for path in paths
    file = fs.readFileSync path, 'utf-8'
    filename = pathUtils.parse(path).name
    order = parseInt /^([0-9]+)\-/.exec(filename)?[1] or NaN
    if order >= 0
        name = "api/#{filename.slice(String(order).length + 1)}"
    else
        name = "api/#{filename}"
    title = (/^#([^#\n]+)$/m.exec(file)?[1] or 'Unknown Title').trim()
    pages.push
        page: API_PAGE
        html: marked.toHTML file, name
        name: name
        title: title
        order: order

pages.sort (a, b) -> a.order - b.order

getNav = do ->
    json = fs.readFileSync API_SUMMARY_PATH, 'utf-8'
    (activePageName) ->
        nav = JSON.parse json
        parseNav = (nav) ->
            for elem in nav
                elem.hasSubnav = elem.nav.length > 0
                elem.active = elem.name is activePageName
                parseNav elem.nav
        parseNav nav
        nav

for page, i in pages
    page.nav = getNav page.name
    exports.push page
