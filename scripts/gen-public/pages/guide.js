var GUIDE_FILES, GUIDE_PAGE, exports, file, filename, fs, getNav, glob, i, j, k, len, len1, marked, name, order, page, pages, path, pathUtils, paths, ref, ref1, title;

glob = require('glob');

fs = require('fs');

pathUtils = require('path');

marked = require('../marked');

({GUIDE_PAGE, GUIDE_FILES} = require('../config'));

exports = module.exports = [];

pages = [];

paths = glob.sync(GUIDE_FILES);

for (j = 0, len = paths.length; j < len; j++) {
  path = paths[j];
  file = fs.readFileSync(path, 'utf-8');
  filename = pathUtils.parse(path).name;
  order = parseInt(((ref = /^([0-9]+)\-/.exec(filename)) != null ? ref[1] : void 0) || (0/0));
  if (order >= 0) {
    name = `guide/${filename.slice(String(order).length + 1)}`;
  } else {
    name = `guide/${filename}`;
  }
  title = (((ref1 = /^#([^#\n]+)$/m.exec(file)) != null ? ref1[1] : void 0) || 'Unknown Title').trim();
  pages.push({
    page: GUIDE_PAGE,
    html: marked.toHTML(file, name),
    name: name,
    title: title,
    order: order
  });
}

pages.sort(function(a, b) {
  return a.order - b.order;
});

getNav = function() {
  var i, k, len1, page, results;
  results = [];
  for (i = k = 0, len1 = pages.length; k < len1; i = ++k) {
    page = pages[i];
    results.push({
      name: page.name,
      title: page.title
    });
  }
  return results;
};

for (i = k = 0, len1 = pages.length; k < len1; i = ++k) {
  page = pages[i];
  page.nav = getNav();
  page.nav[i].active = true;
  exports.push(page);
}
