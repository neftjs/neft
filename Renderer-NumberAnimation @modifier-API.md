NumberAnimation @modifier
=========================

```nml
`Rectangle {
`   width: 100; height: 100
`   color: 'red'
`   NumberAnimation {
`       running: true
`       property: 'x'
`       from: 0
`       to: 300
`       loop: true
`       duration: 1700
`   }
`}
```

*NumberAnimation* NumberAnimation.New([*Component* component, *Object* options])
--------------------------------------------------------------------------------

*NumberAnimation* NumberAnimation() : *Renderer.PropertyAnimation*
------------------------------------------------------------------

*Float* NumberAnimation::from
-----------------------------

*Float* NumberAnimation::to
---------------------------

