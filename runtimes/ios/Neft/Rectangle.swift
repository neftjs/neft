import UIKit

class Rectangle: Item {
    override class func register(_ app: GameViewController){
        app.client.actions[InAction.createRectangle] = {
            (reader: Reader) in
            Rectangle(app)
        }
        app.client.actions[InAction.setRectangleColor] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setColor(reader.getInteger())
        }
        app.client.actions[InAction.setRectangleRadius] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setRadius(reader.getFloat())
        }
        app.client.actions[InAction.setRectangleBorderColor] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setBorderColor(reader.getInteger())
        }
        app.client.actions[InAction.setRectangleBorderWidth] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setBorderWidth(reader.getFloat())
        }
    }
    
    class ShapeLayer: CAShapeLayer {
        static let defaultFillColor = UIColor.clear.cgColor
        static let defaultBorderColor = UIColor.clear.cgColor
        
        override init() {
            super.init()
            self.fillColor = ShapeLayer.defaultFillColor
            self.borderColor = ShapeLayer.defaultBorderColor
            self.miterLimit = 0
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    var layer = ShapeLayer()
    var radius: CGFloat = 0
    
    fileprivate func updatePath() {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        if radius > 0 {
            let radius = min(self.radius, width / 2, height / 2)
            layer.path = CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
        } else {
            layer.path = CGPath(rect: rect, transform: nil)
        }
    }
    
    override func updateBounds() {
        super.updateBounds()
        layer.frame.size = bounds.size
        updatePath()
    }
    
    func setColor(_ val: Int){
        layer.fillColor = Color.hexColorToCGColor(val)
        invalidate()
    }
    
    func setRadius(_ val: CGFloat){
        self.radius = val
        updatePath()
        invalidate()
    }
    
    func setBorderColor(_ val: Int){
        layer.strokeColor = Color.hexColorToCGColor(val)
        invalidate()
    }
    
    func setBorderWidth(_ val: CGFloat){
        layer.lineWidth = val * 2
        layer.masksToBounds = val > 0 // hide outer border
        invalidate()
    }
    
    override func drawShape(_ context: CGContext, inRect rect: CGRect) {
        layer.render(in: context)
    }
}

