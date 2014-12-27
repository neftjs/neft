View
====

@desc How to represent data?

### Introduction

This module is used to represent data in some understood format for programs.

Of course, you certeinly saw this graph on the welcome page.
The graph below visualize application structure written in the *Neft* framework.

```nml,showcase
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

You write document in the *XML* format using some special tags (all prefixed by `neft:`).
Your document will be automatically transformed into necessary format.

Each view gots required data from the `App Handler`, `App Controller` or `App Route`
(commonly), but low-level access is allowed as well.

Brings data can be changed in runtime (when `Dict` or `List` are used), which will
automatically change the result. This technique is commonly used on the client side, where
screens are dynamic and may change (e.g. newest *twitts* updated in runtime).

### *JSON* output

Do you communicate by the API? Remember to ***Don't Repeat Yourself***!
Your `XML` document can be transformed into the `JSON` format.

It's important to be more *XML* than *HTML*, so use true names for tags and attributes!

```view,example
<users>
  <user>
    <name>John</name>
  </user>
</users>
```

### *HTML* output

All unknown tags will be changed into *HTML* ones, best fitting related to the context.

Prepared code will be focused for *SEO*.

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

#### What, if I prefer pedantic *HTML*?

You shouldn't waste your time. *HTML* is served only for searching robots and text
browsers. You should focus on the logical part, because programs will understood better
*JSON* format. Also `Google Search` now supports *JSON-LD* and other formats.

	'use strict'

	module.exports = require './file'