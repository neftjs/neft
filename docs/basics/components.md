# Components

Each component should have exactly one purpose.
To make complex apps easy to develop you need to split and organize them.

## <n-import />

This tag imports other component file and let you use it.

```html
<n-import src="src/components/user-avatar" as="user-avatar" />

<div>
    Hi {user.name}
    <user-avatar user={user} />
</div>
```

## <n-use />

By default imported components are accessible directly by their names.
If you want to place a component but with generated name, use `<n-use />`.

```html
<n-import src="src/components/user-big-avatar" as="user-big-avatar" />
<n-import src="src/components/user-small-avatar" as="user-small-avatar" />

<n-use n-component="user-{avatarSize}-avatar" user={user} />
```

## <n-props />

In the previous examples we were passing `user` attribute to the `user-avatar` component.

You can accept any properties passed to your component and use them directly in your view.

Make sure to list them using the `<n-props />` tag.

```html
// src/components/user-avatar.html

<n-props user />

<img src={user.avatar} />
```

## <n-slot />

If you have a component `src/components/message/message.html`:

```html
<p><n-slot /></p>
```

and you want to use it like that:

```html
<n-import src="src/components/message" as="message" />

<message>
    <img src="..." />
    <button>Details</button>
</message>
```

The given `img` and `button` tags will be placed in `n-slot`.

## <n-component />

Multiple components can be created at once in one file.
Try to use this option only if creating multiple files is a overkill.
Use `<n-component />` with specified `name` attribute.
