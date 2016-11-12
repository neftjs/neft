`neft:fragment` is a template for repeated pieces of code.

Fragment can be rendered by the `neft:use` tag.

```html
<neft:fragment neft:name="avatar">
    <!-- user avatar view -->
</neft:fragment>

<neft:use neft:fragment="avatar" />
<!-- or just -->
<use:avatar />
```