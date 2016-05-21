> [Wiki](Home) ▸ [API Reference](API-Reference)

Database
<dl><dt>Syntax</dt><dd>Database @library</dd></dl>
Access it with:
```javascript
var db = require('db');
```

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#database-library)

OBSERVABLE
<dl><dt>Syntax</dt><dd>[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) db.OBSERVABLE</dd><dt>Static property of</dt><dd><i>db</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#integer-dbobservable)

get
<dl><dt>Syntax</dt><dd>db.get(*String* key, [[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) options], *Function* callback)</dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>options — <i>Integer</i> — <i>optional</i></li><li>callback — <i>Function</i></li></ul></dd></dl>
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
<dl><dt>Syntax</dt><dd>db.set(*String* key, *Any* value, [*Function* callback])</dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbsetstring-key-any-value-function-callback)

remove
<dl><dt>Syntax</dt><dd>db.remove(*String* key, [*Any* value, *Function* callback])</dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i> — <i>optional</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbremovestring-key-any-value-function-callback)

append
<dl><dt>Syntax</dt><dd>db.append(*String* key, *Any* value, [*Function* callback])</dd><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbappendstring-key-any-value-function-callback)

DbList
<dl><dt>Syntax</dt><dd>*DbList* DbList() : [*List*](/Neft-io/neft/wiki/List-API.md#class-list)</dd><dt>Extends</dt><dd><i>List</i></dd><dt>Returns</dt><dd><i>DbList</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblist-dblist--list)

disconnect
<dl><dt>Syntax</dt><dd>DbList::disconnect()</dd><dt>Prototype method of</dt><dd><i>DbList</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblistdisconnect)

DbDict
<dl><dt>Syntax</dt><dd>*DbDict* DbDict() : [*Dict*](/Neft-io/neft/wiki/Dict-API.md#class-dict)</dd><dt>Extends</dt><dd><i>Dict</i></dd><dt>Returns</dt><dd><i>DbDict</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdict-dbdict--dict)

disconnect
<dl><dt>Syntax</dt><dd>DbDict::disconnect()</dd><dt>Prototype method of</dt><dd><i>DbDict</i></dd></dl>
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdictdisconnect)

