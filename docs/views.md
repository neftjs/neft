# Views

Views on the client side are used to organize and handle rendered elements.
They can be also used to serve HTML documents for crawlers (e.g. GoogleBot).

All views must be placed in the `/views` folder and use *XHTML* format.

View file does not have to be fully compatible with the *XML* standard. You cannot use self-enclosing tags from *HTML* (write `<meta />` instead of `<meta>`).

`views/index.xhtml` file is rendered as the first page.

All elements inside the `<body>` tag are rendered.

Each element in the view file can be stylized, but for now, lets learn about some predefined elements available in Neft:

## String Interpolation

String interpolation can be used in texts and in attribute values.

Value you want to render put in `${…}`, just like in *EcmaScript 6 String Template*.

Inside the brackets you can use data from different places like [routes](/routing.md), *XHTML* tags, scripts and others. You will learn more about it later. For now, let's remember that `state` is an object where you can store data for a view.

```xhtml
<h1>${state.title}</h1>
```

Will render any string you saved in a `state` object under the `title` key inside the `h1` tag.

```xhtml
<img src="${state.image}" />
```

Will put any string you saved as `state.image` into `src` attribute.

## log

For the debug purposes you can use `<log />` tag.

This tag logs the given attributes and the whole body into a console.

Each *string interpolation* change is detected and the whole tag is logged.

```xhtml
<log userData="${state.data}">${state.text}</log>
```

## Properties Evaluation

Some of the properties are automatically evaluated to JavaScript objects.

String `[...]` evaluates to an array.
```xhtml
<log list="[1, 2]" />
```
```xhtml
<log list="[{name: 't-shirt'}]" />
```

String `List(...)` evaluates to [List](/data-binding.html#list).
```xhtml
<log list="List([1, 2])" />
```

String `{...}` evaluates to an object.
```xhtml
<log object="{name: 'Johny'}" />
```

String `Dict(...)` evaluates to [Dict](/data-binding.html#dict).
```xhtml
<log object="Dict({name: 'Johny'})" />
```

## n-if

This attribute is used to hide or show the tag depends on the given condition.

If the given *string interpolation* evalues to *falsy* result,
the whole tag is being hidden.

```xhtml
<span n-if="${state.isUserLogged}">Hi ${state.userName}!</span>
```

`n-else` attribute may be specified in the next sibling.

```xhtml
<span n-if="${state.isUserLogged}">Hi ${state.userName}!</span>
<span n-else>You need to log in</span>
```

## n-each

`n-each` attribute repeats tag body for each element of the given list.

```xhtml
<ul n-each="[1, 2]">
    <li>ping</li> <!-- rendered twice -->
</ul>
```

Inside the repeated tag body you can refer to:
 - `props.index` - current element index from a list,
 - `props.item` - current element from a list,
 - `props.each` - `n-each` attribute (e.g. an array or a [List](/api/list.html)).

```xhtml
<ul n-each="[1, 2, 3]">
    <li>Index=${props.index}; element=${props.item}; array=${props.each}</li>
</ul>
```

## ref

Tags with the `ref` attribute are available in the `refs` object.

```xhtml
<input type="text" ref="userNameInput" value="Max" />
<h1>Your name: ${refs.userNameInput.props.value}</h1>
```

# prop

This tag is used to dynamically change the given property on the parent element.

```xhtml
<header ref="header">
    <prop name="isActive" value="true" n-if="${state.isActive}" />
    <span>Active: ${refs.header.props.isActive}</span>
</header>
```

# component

This tag is used to create separated and repeatable parts of a document.

Each component has to define a unique `name`.

*Component* can be created using the *<use />* tag,
or by creating a tag with the component name.

It's recommended to start component names with a big letter.

```xhtml
<component name="Avatar">
    <!-- user avatar here -->
</component>

<use component="Avatar" />
<!-- or just -->
<Avatar />
```

`Use[component]` attribute can be changed in runtime.

```xhtml
<component name="H1">
    <h1>H1 heading</h1>
</component>

<use component="H${state.headingLevel}" />
```

# import

This tag is used to import *component*s from other files.

The *href* attribute can be an absolute path (e.g. `/file.xhtml`),
relative to the current file position (e.g. `./file.xhtml`), or
relative to the *views* folder (e.g. `file.xhtml`).

All imported files are accessible inside the document.

```xhtml
<import href="./user_utils.xhtml" />
<Avatar /> <!-- defined as a <component /> in user_utils.xhtml file -->
```

Optional `as` attribute specifies a namespace for imported components.

```xhtml
<import href="./user_utils.xhtml" as="User" />
<User:Avatar />
<User /> <!-- renders the whole file -->
```

# target

This tag is used in a *component* to define where the given children should be placed.

```xhtml
<component name="User">
    <target /> <!-- <superPower type="flying" /> -->
</component>

<User>
    <superPower type="flying" />
</User>
```

# blank

The best on the end.

Only children of this tag are rendered.

```xhtml
<blank n-each="['Big', 'Ben']">
    <User name="${props.item}" />
</blank>
```
