# What it is

Neft is a framework to write multiplatform apps.

It can run on iOS, Android, MacOS, inside the browser using HTML or WebGL and on your backend.

App can be written in JavaScript or any language which compiles to it (e.g. TypeScript).

Platform functionalities can be extended by writing code in Swift for iOS/MacOS or in Kotlin/Java for Android. Then communicate with your JavaScript code.

# How it works

Neft runs JavaScript environment on a device and communicate with it.

Each platform implements its own rendering system (UIKit for iOS, Views for Android, Cocoa for MacOS, HTML or WebGL for browser).

Your app is a bunch of components. Component is an HTML file which includes view of your component, script (code to work with your view) and styles.

Each part is platform-independent and runs in the same way no matter on which platform it is.

Styles are not CSS, but something with similar syntax yet different possibilities.

# How to start

Try to edit the code below and see how the view changes.

Install "Neft Playground" app on your iOS or Android device and connect it by using the special code "Your Code".

```neft
<main>
  <button onClick={decrement()}>-</button>
  <span>{value}</span>
  <button onClick={increment()}>+</button>
</main>

<script>
export default () => ({
  value: 0,
  increment() {
    this.value += 1
  },
  decrement() {
    this.value -= 1
  },
})
</script>

<style>
main {
  layout: 'row'
  height: 50

  * {
    fillWidth: true
    fillHeight: true
  }

  span {
    alignment: 'center'
    font.pixelSize: 20
  }
}
</style>
```

Continue to read this documentation to learn more about Neft. You can still use the built-in editor or install Neft on your machine.
