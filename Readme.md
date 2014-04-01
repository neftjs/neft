TODO Application
================

Build simply *TODO* application to test all possible features.
This app should works on the server and client side with *offline* support.

Registered users should have a list with already created messages and
button to create new one. Messages can be updated.

Schema
------

### User

1. email
2. password
3. created

### Item

1. user_id
2. msg
3. updated
4. created

Models
------

### *ModelDb* *DbAddonsSchema* User

### *ModelDb* *DbAddonsSchema* Item