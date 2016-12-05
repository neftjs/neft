# Layout


To position children in an item, you can use few methods:
 - absolute positioning (`x` and `y` properties),
 - from left to right - `Flow` type,
 - on a grid - `Grid`, `Column`, `Row` types,
 - anchors.

### Flow

Flow element position items from left to right.

```javascript
Flow {
    width: 400

    Rectangle {
        width: 100
        height: 100
        margin.bottom: 20
    }

    Rectangle {
        layout.fillWidth: true
    }
}
```

### Grid

Grid positions its children in a grid formation.

Other elements similar to `Grid` are `Column` and `Row`.

```javascript
Grid {
    columns: 2
    spacing: 20

    Rectangle {
        width: 100
        height: 100
    }

    Rectangle {
        width: 100
        height: 100
    }
}
```

### Anchor

`Item::anchor` describes relation between two items.
Each item has few lines: top, verticalCenter, bottom, left, horizontalCenter and bottom.

You can stick an item line into another item line. For the performance reasons, you can anchor only to siblings or to the item parent.

```javascript
Item {
    Rectangle {
        id: rect1
    }

    Rectangle {
        anchors.left: rect1.right
        margin.left: 20
    }
}
```
