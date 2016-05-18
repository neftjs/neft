> [Wiki](Home) ▸ [API Reference](API-Reference) ▸ **Database @library**

Database @library
=================

Access it with:
```javascript
var db = require('db');
```

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#database-library)

## Table of contents
  * [db.OBSERVABLE](#integer-dbobservable)
  * [db.get(key, [options], callback)](#dbgetstring-key-integer-options-function-callback)
  * [db.set(key, value, [callback])](#dbsetstring-key-any-value-function-callback)
  * [db.remove(key, [value, callback])](#dbremovestring-key-any-value-function-callback)
  * [db.append(key, value, [callback])](#dbappendstring-key-any-value-function-callback)
  * [DbList() : *List*](#dblist-dblist--list)
  * [disconnect()](#dblistdisconnect)
  * [DbDict() : *Dict*](#dbdict-dbdict--dict)
  * [disconnect()](#dbdictdisconnect)

[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) db.OBSERVABLE
-----------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#integer-dbobservable)

db.get(*String* key, [[*Integer*](/Neft-io/neft/wiki/Utils-API.md#boolean-isintegerany-value) options], *Function* callback)
--------------------------------------------------------------

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

db.set(*String* key, *Any* value, [*Function* callback])
--------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbsetstring-key-any-value-function-callback)

db.remove(*String* key, [*Any* value, *Function* callback])
-----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbremovestring-key-any-value-function-callback)

db.append(*String* key, *Any* value, [*Function* callback])
-----------------------------------------------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbappendstring-key-any-value-function-callback)

*DbList* DbList() : [*List*](/Neft-io/neft/wiki/List-API.md#class-list)
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblist-dblist--list)

DbList::disconnect()
--------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblistdisconnect)

*DbDict* DbDict() : [*Dict*](/Neft-io/neft/wiki/Dict-API.md#class-dict)
--------------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdict-dbdict--dict)

DbDict::disconnect()
--------------------

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdictdisconnect)

