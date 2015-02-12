Basic items
===========

Core items used as base for other, more complex items.

[Item](/docs/renderer/basic-elements/item) is extended by all visible items.

```style
\Image {
\  width: 200
\  height: 150
\  source: 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="255" height="240" viewBox="0 0 51 48"><path fill="yellow" stroke="#000" d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/></svg>'
\  rotation: Math.PI / 8
\
\  Text {
\    text: 'NEFT'
\    font.weight: 0.8
\    anchors.centerIn: parent
\    margin.top: 10
\  }
\}
```