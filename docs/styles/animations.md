# Animations



## Number animation

Neft supports animating number properties.
Use `NumberAnimation` to achieve this goal.

By default animator animates item, in which it was created.

```javascript
Item {
    NumberAnimation {
        property: 'x'
        from: 0
        to: 1000
        loop: true
    }
}
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
