import Cocoa

class Rectangle: Item {

    override class func register() {
        onAction(.createRectangle) {
            save(item: Rectangle())
        }

        onAction(.setRectangleColor) {
            (item: Rectangle, val: CGColor) in
            item.layer.backgroundColor = val
        }

        onAction(.setRectangleRadius) {
            (item: Rectangle, val: CGFloat) in
            item.layer.cornerRadius = val
        }

        onAction(.setRectangleBorderColor) {
            (item: Rectangle, val: CGColor) in
            item.layer.borderColor = val
        }

        onAction(.setRectangleBorderWidth) {
            (item: Rectangle, val: CGFloat) in
            item.layer.borderWidth = val
        }
    }

}
