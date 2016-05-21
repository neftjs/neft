> [Wiki](Home) ▸ [API Reference](API-Reference)

Database
<dl><dt>Syntax</dt><dd><code>Database @library</code></dd></dl>
Access it with:
```javascript
var db = require('db');
```

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#database-library)

OBSERVABLE
<dl><dt>Syntax</dt><dd><code>&#x2A;Integer&#x2A; db.OBSERVABLE</code></dd><dt>Static property of</dt><dd><i>db</i></dd><dt>Type</dt><dd><a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#integer-dbobservable)

get
<dl><dt>Syntax</dt><dd><code>db.get(&#x2A;String&#x2A; key, [&#x2A;Integer&#x2A; options], &#x2A;Function&#x2A; callback)</code></dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>options — <a href="/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value">Integer</a> — <i>optional</i></li><li>callback — <i>Function</i></li></ul></dd></dl>
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

> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dbgetstring-key-integer-options-function-callback)

set
<dl><dt>Syntax</dt><dd><code>db.set(&#x2A;String&#x2A; key, &#x2A;Any&#x2A; value, [&#x2A;Function&#x2A; callback])</code></dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dbsetstring-key-any-value-function-callback)

remove
<dl><dt>Syntax</dt><dd><code>db.remove(&#x2A;String&#x2A; key, [&#x2A;Any&#x2A; value, &#x2A;Function&#x2A; callback])</code></dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i> — <i>optional</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dbremovestring-key-any-value-function-callback)

append
<dl><dt>Syntax</dt><dd><code>db.append(&#x2A;String&#x2A; key, &#x2A;Any&#x2A; value, [&#x2A;Function&#x2A; callback])</code></dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dbappendstring-key-any-value-function-callback)

DbList
<dl><dt>Syntax</dt><dd><code>&#x2A;DbList&#x2A; DbList() : &#x2A;List&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/List-API.md#class-list">List</a></dd><dt>Returns</dt><dd><i>DbList</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dblist-dblist--list)

disconnect
<dl><dt>Syntax</dt><dd><code>DbList::disconnect()</code></dd><dt>Prototype method of</dt><dd><i>DbList</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dblistdisconnect)

DbDict
<dl><dt>Syntax</dt><dd><code>&#x2A;DbDict&#x2A; DbDict() : &#x2A;Dict&#x2A;</code></dd><dt>Extends</dt><dd><a href="/Neft-io/neft/wiki/Dict-API.md#class-dict">Dict</a></dd><dt>Returns</dt><dd><i>DbDict</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dbdict-dbdict--dict)

disconnect
<dl><dt>Syntax</dt><dd><code>DbDict::disconnect()</code></dd><dt>Prototype method of</dt><dd><i>DbDict</i></dd></dl>
> [`Source`](/Neft-io/neft/blob/feb74662c4f7ee7aedc58bcb4488ea1b56f65be9/src/db/index.litcoffee#dbdictdisconnect)

