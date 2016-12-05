# Database

> **API Reference** ▸ **Database**

<!-- toc -->
Access it with:
```javascript
var db = require('db');
```


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee)


* * * 

### `db.OBSERVABLE`

<dl><dt>Static property of</dt><dd><i>db</i></dd><dt>Type</dt><dd><i>Integer</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#integer-dbobservable)


* * * 

### `db.get()`

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>options — <i>Integer</i> — <i>optional</i></li><li>callback — <i>Function</i></li></ul></dd></dl>

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


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dbgetstring-key-integer-options-function-callback)


* * * 

### `db.set()`

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dbsetstring-key-any-value-function-callback)


* * * 

### `db.remove()`

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i> — <i>optional</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dbremovestring-key-any-value-function-callback)


* * * 

### `db.append()`

<dl><dt>Static method of</dt><dd><i>db</i></dd><dt>Parameters</dt><dd><ul><li>key — <i>String</i></li><li>value — <i>Any</i></li><li>callback — <i>Function</i> — <i>optional</i></li></ul></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dbappendstring-key-any-value-function-callback)


* * * 

### `DbList()`

<dl><dt>Extends</dt><dd><i>List</i></dd><dt>Returns</dt><dd><i>DbList</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dblist-dblist--list)


* * * 

### `disconnect()`

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dblistdisconnect)


* * * 

### `DbDict()`

<dl><dt>Extends</dt><dd><i>Dict</i></dd><dt>Returns</dt><dd><i>DbDict</i></dd></dl>


> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dbdict-dbdict--dict)


* * * 

### `disconnect()`

> [`Source`](https:/github.com/Neft-io/neft/blob/f9c128ccb37aa79380c961e878cd76ec9e79c99e/src/db/index.litcoffee#dbdictdisconnect)

