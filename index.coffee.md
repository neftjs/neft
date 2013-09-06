Db abstract
===========

**Author:** *kildyt@gmail.com*

**License:** *MIT*

	'use strict'

### Naming

*  **Database** - root class for tables,
*  **Table** - collection of stored documents,
*  **Collection** - array of documents,
*  **Document** - pure JS object,
*  **id** - unique object/string/number for each documents,
*  **row** - property name from *Document*.

### Purposes

1.  Create tiny and simply abstract for get, remove, insert and update documents.
2.  Design API to simply implement it on the backend and frontend using no-sql
    and sql databases (e.g. IndexedDB, MongoDB).
3.  Focus on design userfriendly API (performance is not really important).
4.  Add support for different dabatabses and tables.
5.  Provide helpers for documents.
6.  Support manipulating on collection of documents.

### Examples

1.  Remove document
    ```
    new Db('db', 'table', 'id').remove()()
    ```

2.  Update two documents (started from the second one) where title is 'Best'
    changing title to 'The Best'.
    ```
    new Db('db', 'table')
     .where('title').is('Best')
     .limit(2)
     .offset(1)
     .insert(title: 'The Best')()
    ```

Index
-----

This is only a index file.
All sub-files and needed dependencies are loading.
Check [my repos](https://github.com/Kildyt/) for needed packages.
It's async operation, because [`browser_module`](https://github.com/Kildyt/browser_module)
are supported.

Check `Db.coffee.md` file next.

Exports module if dependencies are ready. Look at `Initialization` section.

	ready = ->

		module.exports = require './Db.coffee.md'

		Db = module.exports

		ok = -> console.log(':)')
		error = -> console.log(':(', arguments)

		console.log 1, new Db('db', 'table')
			.where('name')
			.is('Bob')
			.then(ok, error)()


Initialization
--------------

Support [`browser_module`](https://github.com/Kildyt/browser_module)

	if Module?.load

		Module.load(
			'Promise', 'Events', 'utils',
			'./Db.coffee.md',
			'./Database.coffee.md', './Table.coffee.md',
			'./Collection.coffee.md', './Document.coffee.md',
			ready)

	else

		ready()