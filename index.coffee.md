Db abstract
===========

**Author:** *kildyt@gmail.com*

**License:** *MIT*

	'use strict'

### Naming

*  **Database** - root class for tables,
*  **Table** - collection of stored documents,
*  **Collection** - list of documents,
*  **id** - unique object/string/number for each documents,
*  **row** - property name from document.

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
    and change title to 'The Best'.
    ```
    new Db('db', 'table')
     .where('title').is('Best')
     .skip(1)
     .limit(2)
     .insert(title: 'The Best')()
    ```

Index
-----

This is only a index file.
All sub-files and needed dependencies are loading.
Check [my repos](https://github.com/Kildyt/) for needed packages.

Check `Db.coffee.md` file next.

	module.exports = require './Db.coffee.md'