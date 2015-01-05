View
====

@desc How to represent data?

### Introduction

This module is used to represent data in some understood format for programs.

Of course, you certeinly saw this graph on the welcome page.
The graph below visualize application structure written in the *Neft* framework.

```nml,render
AppStructure {
	active: 'view'
}
```

As you see, *models* have some raw data and *routes* knows how to respond for the requests.
Did we missed something?

Yes! If someone asks us about some stuff (sends us a `get` request), we handle it, collect
some data and finally respond him sending required answers.

In practice, `Google Search` robot sends a `get` request and parse got data.

### How it works

You write document normal *HTML* document using some special tags (all prefixed by `neft:`).

Each view gots required data from the `App Handler`, `App Controller` or `App Route`
(commonly), but low-level access is allowed as well.

Brings data can be changed in runtime (when `Dict` or `List` are used), which will
automatically change the result. This technique is commonly used on the client side, where
screens are dynamic and may change (e.g. newest *twitts* updated in runtime).

### How to use this module

All features of this module are provided by the hight-level APIs.

If you missed that, please read more about it in the `Application Structure` article.

### Questions

#### My application works only on the client side. What I should do?

You don't answer to the robots and external clients, but you still need to visualize
your data. This module is also used to communicate with the `Renderer` (check `Styles`),
so you defintely should use this to keep your logic and visual sides clean and separated.

#### Should I use `view` for games?

Good question. It depends on the type of game which you develop.
It's a good pattern to always keep some small `view` part even
if you don't have a lot of GUI elements.
Communication between the logic part (`App Route` etc.) and the `Renderer` is
more pleasant by the `Styles` which are integrated into this module.

	'use strict'

	module.exports = require './file'