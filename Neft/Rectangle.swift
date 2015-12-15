import SpriteKit

extension Renderer {
    class Rectangle: Renderer.BaseType {
        class Node: Item.Node {
            let shape = SKShapeNode()
            var radius: CGFloat = 0
            override var width: CGFloat {
                didSet {
                    self.updatePath()
                }
            }
            override var height: CGFloat {
                didSet {
                    self.updatePath()
                }
            }
            
            override init(_ renderer: Renderer) {
                super.init(renderer)
                self.shape.lineWidth = 0
                self.shape.lineJoin = .Miter
                self.childrenNode.addChild(self.shape)
            }

            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func updatePath(){
                let path = CGPathCreateMutable()
                let rect = CGRect(x: 0, y: -height, width: width, height: height)
                let radius = min(self.radius, width / 2, height / 2)
                if radius > 0 {
                    CGPathAddRoundedRect(path, nil, rect, radius, radius)
                } else {
                    CGPathAddRect(path, nil, rect)
                }
                shape.path = path
            }
        }
        
        override init(app: GameViewController){
            super.init(app: app)
            Renderer.actions[InActions.CREATE_RECTANGLE] = self.create
            Renderer.actions[InActions.SET_RECTANGLE_COLOR] = self.setColor
            Renderer.actions[InActions.SET_RECTANGLE_RADIUS] = self.setRadius
            Renderer.actions[InActions.SET_RECTANGLE_BORDER_COLOR] = self.setBorderColor
            Renderer.actions[InActions.SET_RECTANGLE_BORDER_WIDTH] = self.setBorderWidth
        }
        
        func create(reader: Reader){
            Node(renderer)
        }
        
        func setColor(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let color = reader.getInteger()
            item.shape.fillColor = hexColorToUIColor(color)
        }
        
        func setRadius(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.radius = val
            item.updatePath()
        }
        
        func setBorderColor(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let color = reader.getInteger()
            item.shape.strokeColor = hexColorToUIColor(color)
        }
        
        func setBorderWidth(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.shape.lineWidth = val
        }
    }
}
