# Animations

Neft allows to dynamically change properties like position or size.

It can be easily used to animate such properties but can be not efficient enough.

To speed up such operations, Neft provides *Animators*.

## Animators

## NumberAnimation

This animator animates any property which stores numbers.

Use it to animate position, size, rotation, scale and more.

```xhtml
<style>
Item {
    pointer.onClick: function () {
        xAnimator.start();
    }

    NumberAnimation {
        id: xAnimator
        property: 'x'
        from: 0
        to: 1000
    }
}
</style>
```

By default animators don't update the property during animation (it's much faster).
To change this behaviour, switch the `PropertyAnimation::updateProperty` boolean.

## Transitions

Transition type automatically animate all updates on the given property.

```javascript
Item {
    width: 205

    if (this.pointer.hover){
        x: 100
    }

    Transition {
        when: this.target.width > 200
        property: 'x'
        animation: NumberAnimation {
            startDelay: 500
            easing: 'OutSine'
        }
    }
}
```
