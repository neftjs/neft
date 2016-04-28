import UIKit

class Rectangle: Item {
    override class func register(app: GameViewController){
        app.client.actions[InAction.CREATE_RECTANGLE] = {
            (reader: Reader) in
            Rectangle(app)
        }
        app.client.actions[InAction.SET_RECTANGLE_COLOR] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setColor(reader.getInteger())
        }
        app.client.actions[InAction.SET_RECTANGLE_RADIUS] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setRadius(reader.getFloat())
        }
        app.client.actions[InAction.SET_RECTANGLE_BORDER_COLOR] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setBorderColor(reader.getInteger())
        }
        app.client.actions[InAction.SET_RECTANGLE_BORDER_WIDTH] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Rectangle)
                .setBorderWidth(reader.getFloat())
        }
    }
    
    class ShapeLayer: CAShapeLayer {
        static let defaultFillColor = UIColor.clearColor().CGColor
        static let defaultBorderColor = UIColor.clearColor().CGColor
        
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
    
    private func updatePath() {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        if radius > 0 {
            let radius = min(self.radius, width / 2, height / 2)
            layer.path = CGPathCreateWithRoundedRect(rect, radius, radius, nil)
        } else {
            layer.path = CGPathCreateWithRect(rect, nil)
        }
    }
    
    override func updateBounds() {
        super.updateBounds()
        layer.frame.size = bounds.size
        updatePath()
    }
    
    func setColor(val: Int){
        layer.fillColor = Color.hexColorToCGColor(val)
        invalidate()
    }
    
    func setRadius(val: CGFloat){
        self.radius = val
        updatePath()
        invalidate()
    }
    
    func setBorderColor(val: Int){
        layer.strokeColor = Color.hexColorToCGColor(val)
        invalidate()
    }
    
    func setBorderWidth(val: CGFloat){
        layer.lineWidth = val * 2
        layer.masksToBounds = val > 0 // hide outer border
        invalidate()
    }
    
    override func drawShape(context: CGContextRef, inRect rect: CGRect) {
        layer.renderInContext(context)
    }
}

