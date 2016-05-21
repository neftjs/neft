> [Wiki](Home) ▸ [API Reference](API-Reference)

<dl></dl>
Database
Access it with:
```javascript
var db = require('db');
```

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#database-library)

<dl><dt>Static property of</dt><dd><i>db</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>
OBSERVABLE
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#integer-dbobservable)

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>options</b> — <i>Integer</i> — <i>optional</i></li><li><b>callback</b> — <i>Function</i></li></ul></dd></dl>
get
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

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>value</b> — <i>Any</i></li><li><b>callback</b> — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
set
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbsetstring-key-any-value-function-callback)

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>value</b> — <i>Any</i> — <i>optional</i></li><li><b>callback</b> — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
remove
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbremovestring-key-any-value-function-callback)

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li><b>key</b> — <i>String</i></li><li><b>value</b> — <i>Any</i></li><li><b>callback</b> — <i>Function</i> — <i>optional</i></li></ul></dd></dl>
append
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbappendstring-key-any-value-function-callback)

<dl><dt>Extends</dt><dd><i>List</i></dd><dt>Returns</dt><dd><i>DbList</i></dd></dl>
DbList
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblist-dblist--list)

## Table of contents
    * [Database](#database)
    * [OBSERVABLE](#observable)
    * [get](#get)
    * [set](#set)
    * [remove](#remove)
    * [append](#append)
    * [DbList](#dblist)
  * [DbList::disconnect()](#dblistdisconnect)
  * [*DbDict* DbDict() : *Dict*](#dbdict-dbdict--dict)
  * [DbDict::disconnect()](#dbdictdisconnect)

DbList::disconnect()
--------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblistdisconnect)

*DbDict* DbDict() : [*Dict*](/Neft-io/neft/wiki/Dict-API.md#class-dict)
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdict-dbdict--dict)

DbDict::disconnect()
--------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdictdisconnect)

