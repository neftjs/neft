# Template syntax

Each component is an HTML file containing view, script and styles.
In this article we're going to learn how to use the view part.

Values can be injected into you HTML tags using single curly brackets `{...}`. It can by any code you want to evaluate.

You can access values from three places: script, props and refs. More about that you will learn later. For now let's use the `<script>` tag to provide some initial data.

```neft
<div>Value: {value}</div>
<div>Current time: {new Date()}</div>
<div>Image: <img src={imgUrl} /></div>

<script>
export const value = 'injected value'
export const imgUrl = 'https://neft.io/media/logo-white.svg'
</script>
```

Make sure your HTML tags are always closed, so `<img>` needs to become `<img />`.

Neft provides his own internal HTML tags and attributes prefixed by `n-`. You will find more of them in next chapters. For now let's consider two basic ones.

## n-if

It changes presence of an element. "else block" can be achieved with `n-else`.

```neft
<div n-if={ok}>I'm here</div>
<div n-else>I'm hidden</div>

<script>
export const ok = true
</script>
```

Go ahead and change `const ok = true` to `false` in the editor above. The label "I'm here" should change to "I'm hidden".

## n-for

It gives you ability to iterate through arrays. The basic syntax is `n-for="item in {items}"`, where `items` is an array and `item` is a name of variable you can use to access each element.

```neft
<ul n-for="item in {items}">
    <li>{item}</li>
</ul>

<script>
export const items = ["I'm first", "I'm second"]
</script>
```

The more advanced syntax is `n-for="(item, index, array) in {items}"`. It's similar to the arguments passed in `forEach` method on an array. Try to change the code above to render each item of the array and it's index.
