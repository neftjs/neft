neft:if @xml
=======

Attribute used to hide or show the tag depends on the condition result.

```xml
<span neft:if="${user.isLogged}">Hi ${user.name}!</span>
<span neft:else>You need to log in</span>
```

