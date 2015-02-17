Document Modeling
=================

**How to represent data?**

#### Introduction

This module is used to represent data in some understood format for programs.

As you know, *models* have some raw data and *routes* knows how to respond to the requests.
If someone asks us about some stuff (sends us a `get` request), we handle it, collect
some data and finally respond him sending required answers **in an HTML format**.

In practice, the *Google Search* robot sends a `get` request and parse got data.

#### How it works

You write normal *HTML* documents using some special tags (all prefixed by the **neft:**).

Each view gets required data from the *App Controller* or *App Route*
(commonly), but low-level access is allowed as well.

Brings data can be changed at runtime (when [Dict][] or [List][] are used), which will
automatically change the result. This technique is commonly used on the client side, where
screens are dynamic and may change (e.g. newest *tweets* updated at runtime).

#### Questions

##### My application works only on the client side. What I should do?

You don't answer to the robots and external clients, but you still need to visualize
your data. This module is also used to communicate with the `Renderer`,
so you definitely should use this to keep your logic and visual sides clean and separated.

##### Should I use this module for games?

It depends on the type of game which you develop.
It's a good pattern to always keep some small `view` part even
if you don't have a lot of GUI elements.
Communication between the logical part and the rendering is
more pleasant using this module.

	'use strict'

	module.exports = require './file'
