(function () {
    var SEARCH_OPTIONS = {
        expand: true,
        fields: {
            'h1': { boost: 4 },
            'h2': { boost: 3 },
            'h3': { boost: 2 },
        }
    };

    if (typeof searchTexts === "undefined") return;

    var inputElement = document.getElementById('search');
    var resultElement = document.getElementById('searchResult');
    if (!inputElement || !resultElement) return;

    function trimOnlyNonWords(token) {
        return token
            .replace(/\W+/g, ' ')
            .trim();
    }

    function trim(token) {
        return trimOnlyNonWords(token)
            .replace(/([a-z])([A-Z])/g, '$1 $2')
            .trim();
    }

    function buildSearch() {
        var index = elasticlunr(function () {
            this.addField('h1');
            this.addField('h2');
            this.addField('h3');
            this.setRef('id');
            this.saveDocument(false);
        });

        function addDoc(id, level, text) {
            var doc = { id: id };
            doc['h' + level] = text
            index.addDoc(doc);
        }

        var texts = searchTexts.texts;
        for (var i = 0, n = texts.length; i < n; i++) {
            var level = texts[i][1];
            var text = texts[i][2];
            addDoc(i, level, trimOnlyNonWords(text));
            addDoc(i, level, trim(text));
        }
        return index;
    }

    function search(text) {
        var result = [];
        var lunrResult = lunrIndex.search(trim(text), SEARCH_OPTIONS);
        var pages = searchTexts.pages;
        var texts = searchTexts.texts;
        for (var i = 0; i < lunrResult.length; i++) {
            var text = texts[lunrResult[i].ref];
            result.push({
                page: pages[text[0]],
                text: text[2]
            });
        }
        return result;
    }

    function showResult(value, result) {
        if (!result.length) {
            resultElement.innerHTML = "";
            return
        }

        var markRe = new RegExp('('+value.split(' ').join('|')+')', 'ig');

        var html = '<ul>';

        for (var i = 0; i < result.length; i++) {
            var uri = "/" + result[i].page + ".html";
            var text = result[i].text.replace(markRe, "<mark>$1</mark>");
            html += "<li><a href=\"" + uri + "\">" + text + "</a></li>";
        }

        html += "</ul>";

        resultElement.innerHTML = html;
    }

    function listenOnElement() {
        var lastSearchResult;
        inputElement.addEventListener('input', function () {
            var value = inputElement.value;
            var searchResult = search(value);
            if (value && !searchResult.length && lastSearchResult) {
                searchResult = lastSearchResult;
            }
            showResult(value, searchResult)
            lastSearchResult = searchResult;
        });
    }

    function updateResultElementMaxHeight() {
        resultElement.style.maxHeight = innerHeight - 100 + "px";
    }

    var lunrIndex = buildSearch();
    listenOnElement();
    window.addEventListener('resize', updateResultElementMaxHeight);
    updateResultElementMaxHeight();
}());
