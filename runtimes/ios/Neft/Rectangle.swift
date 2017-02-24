import UIKit

class Rectangle: Item {
    override class func register() {
        onAction(.createRectangle) {
            save(item: Rectangle())
        }

        onAction(.setRectangleColor) {
            (item: Rectangle, val: CGColor) in
            item.shapeView.layer.backgroundColor = val
        }

        onAction(.setRectangleRadius) {
            (item: Rectangle, val: CGFloat) in
            item.shapeView.layer.cornerRadius = val
        }

        onAction(.setRectangleBorderColor) {
            (item: Rectangle, val: CGColor) in
            item.shapeView.layer.borderColor = val
        }

        onAction(.setRectangleBorderWidth) {
            (item: Rectangle, val: CGFloat) in
            item.shapeView.layer.borderWidth = val
        }
    }

    override var width: CGFloat {
        didSet {
            updateFrame()
        }
    }

    override var height: CGFloat {
        didSet {
            updateFrame()
        }
    }

    let shapeView: UIView

    override init() {
        shapeView = UIView()
        super.init()
        view.addSubview(shapeView)
    }

    private func updateFrame() {
        shapeView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
}

