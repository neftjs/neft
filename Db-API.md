Database @library
=================

Access it with:
```javascript
var db = require('db');
```

*Integer* db.OBSERVABLE
-----------------------

db.get(*String* key, [*Integer* options], *Function* callback)
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

db.set(*String* key, *Any* value, [*Function* callback])
--------------------------------------------------------

db.remove(*String* key, [*Any* value, *Function* callback])
-----------------------------------------------------------

db.append(*String* key, *Any* value, [*Function* callback])
-----------------------------------------------------------

*DbList* DbList() : *List*
--------------------------

DbList::disconnect()
--------------------

*DbDict* DbDict() : *Dict*
--------------------------

DbDict::disconnect()
--------------------

