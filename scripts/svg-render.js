(function() {
    var codes = document.querySelectorAll('code.svg');

    for (var i = 0; i < codes.length; i++) {
        var elem = codes[i];
        elem.innerHTML = elem.textContent;
    }
}());
