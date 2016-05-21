> [Wiki](Home) ▸ [API Reference](API-Reference)

Database
Access it with:
```javascript
var db = require('db');
```

> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#database-library)

OBSERVABLE
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#integer-dbobservable)

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

set
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbsetstring-key-any-value-function-callback)

remove
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbremovestring-key-any-value-function-callback)

append
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbappendstring-key-any-value-function-callback)

DbList
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblist-dblist--list)

disconnect
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dblistdisconnect)

DbDict
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdict-dbdict--dict)

disconnect
> [`Source`](/Neft-io/neft/tree/master/src/db/index.litcoffee#dbdictdisconnect)

