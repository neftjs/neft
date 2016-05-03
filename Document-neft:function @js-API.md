neft:function @js
=================

ReadOnly *Object* globalObject
------------------------------

Used as a global namespace in the function body.

*Function* globalObject.require(*String* moduleName)
----------------------------------------------------

Requires standard Neft modules.

```xml
<neft:function neft:name="test">
</neft:function>
```

*Arguments* globalObject.arguments
----------------------------------

Array-like object with arguments passed to the function.

```xml
<neft:function neft:name="followMouse">
</neft:function>

<button style:pointer:onMove="${funcs.followMouse}" />
```

