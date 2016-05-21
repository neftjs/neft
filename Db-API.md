> [Wiki](Home) ▸ [API Reference](API-Reference)

Database
<dl></dl>
Access it with:
```javascript
var db = require('db');
```

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#database-library)

OBSERVABLE
<dl><dt>Static property of</dt><dd><i>db</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#integer-dbobservable)

get
<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>options</b> — <i>Integer</i> — <i>optional</i></li><li><b>callback</b> — <i>Function</i></li></ul></dd></dl>
```javascript
db.set('items', [], function(){
\  db.get('items', db.OBSERVABLE, function(err, dict){
\    dict.onInserted(function(index){
\      console.log(this.get(index) + ' inserted!');
\    });
\
\    db.append('items', 'item1', function(){
\      // item1 inserted
\    });
\  });
});
```

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbgetstring-key-integer-options-function-callback)

set
<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>value</b> — <i>Any</i></li><li><b>callback</b> — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbsetstring-key-any-value-function-callback)

remove
<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>value</b> — <i>Any</i> — <i>optional</i></li><li><b>callback</b> — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbremovestring-key-any-value-function-callback)

append
<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>value</b> — <i>Any</i></li><li><b>callback</b> — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbappendstring-key-any-value-function-callback)

DbList
<dl><dt>Extends</dt><dd><i>List</i></dd><dt>Returns</dt><dd><i>DbList</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblist-dblist--list)

disconnect
<dl><dt>Prototype method of</dt><dd><i>DbList</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblistdisconnect)

DbDict
<dl><dt>Extends</dt><dd><i>Dict</i></dd><dt>Returns</dt><dd><i>DbDict</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdict-dbdict--dict)

disconnect
<dl><dt>Prototype method of</dt><dd><i>DbDict</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdictdisconnect)

