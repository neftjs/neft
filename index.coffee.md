Document Modeling
=================

**How to represent data?**

This module is used to represent data in understood format for programs.

As you know, *models* have some raw data and *routes* knows how to respond to the requests.
If someone asks the server about some stuff (sends a `get` request), we handle it, collect
some data and finally respond him, sending required answers **in an HTML format**.

#### How it works

You write normal *HTML* documents using some special tags (all prefixed by the **neft:**).

Each view gets required data from the *App Controller* or *App Route*
(commonly), but low-level access is allowed as well.

Data can be changed at runtime (when [Dict][] or [List][] are used), which will
automatically change the result. This technique is commonly used on the client side, where
screens are dynamic and may change (e.g. newest *tweets* updated at runtime).

	'use strict'

	module.exports = require './file'
