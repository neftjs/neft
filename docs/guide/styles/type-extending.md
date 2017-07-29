# Type Extending


Top level objects are available in the `exports` object under their ids.

```javascript
Item {
    id: button
}

exports.button {
    width: 100
}
```

This also works across files.

```javascript
// styles/button.js
Item {
    id: sampleButton
}

// styles/complexButton.js
``
var button = require('./button.js');
``
button.sampleButton {
}
```
