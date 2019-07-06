# Data binding

From the previous article you learn how to inject variables and functions from the `<script />` tag into your view.

Neft provides special data binding system which automatically updates your view when used values change.

It may sounds simply but it's actually a very powerful mechanism.

## <n-call />

Calls provided functions on beginning and on each time any of the given parameter change.

You can use it to perform asynchronous actions like fetching data.

Remember to put each call in curly brackets, just like any other binding.

```neft
<n-call>
    {fetchRecords(page)}
</n-call>

<p>Page: {page}</p>
<p>Loading: {loading}</p>
<p>Items: {items}</p>
<button onClick={page -= 1}>Previous page</button>
<button onClick={page += 1}>Next page</button>

<script>
const wait = ms => new Promise((resolve) => { setTimeout(resolve, ms) })
const data = [
    [1,2],
    [2,3],
    [4,5],
    [6,7],
]

export default () => ({
    page: 0,
    loading: false,
    items: null,
    error: null,
    async fetchRecords(page) {
        try {
            this.error = null
            this.loading = true
            await wait(1000) // some fetching data from a server
            this.items = data[page]
        } catch (error) {
            this.error = error.message
        } finally {
            this.loading = false
        }
    },
})
</script>
```

In the example above we simulate asynchronous fetching data from a server.

Method `fetchRecords` is called on the beginning and on each time argument `page` change.

## <n-log />

Logs attributes and text into a console. It's useful for debugging changing variables.

```html
<n-log counter={counter} />
<button onClick={counter += 1}>Plus one</button>

<script>
export default () => ({
    counter: 0,
})
</script>
```

Log with a message `counter=0`, `counter=1` etc. will be logged to a console.

## Struct

To make bindings work Neft uses two structures `Struct` and `ObservableArray` respectively for objects and arrays.

`Struct` can be used for deep structures and to let track their updates.

It's a good practice to move heavy state manegement scripting to separate files and import them in components.

```javascript
// src/store.js
import { Struct } from '@neft/core'

export default new Struct({
    counter: 0,
    increaseCounter() {
        this.counter += 1
    },
})
```

Such `store` file can be imported in other components and the state will be shared.

```html
// src/components/hello/hello.html

<p>Counter: {store.counter}</p>
<button onClick={store.increaseCounter()}>Increase</button>

<script>
import store from '../store'

export { store }
</script>
```

You cannot add new properties to the created struct.

## ObservableArray

It's a wrapper of standard arrays, but emits signals on each change.

You can use to in your components to e.g. render list of items and change them in runtime.

```neft
<ul n-for="item in {items}">
    <li>{item} <button onClick={removeItem(item)}>Remove</button></li>
</ul>

<script>
import { ObservableArray } from '@neft/core'

export default () => ({
    items: new ObservableArray('First', 'Second', 'Third'),
    removeItem(item) {
        const index = this.items.indexOf(item)
        if (index >= 0) {
            this.items.splice(index, 1)
        }
    }
})
</script>
```

You cannot modify array elements directly, so `this.items[0] = ''` won't work.
