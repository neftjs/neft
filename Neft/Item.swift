import SpriteKit

extension Renderer {
    class Item: Renderer.BaseType {
        class Node: SKNode {
            let id: Int
            let transformNode = SKNode()
            var childrenNode: SKNode
            var cropNode: SKCropNode?
            var cropNodeMask: SKSpriteNode?
            var x: CGFloat = 0
            var y: CGFloat = 0
            var width: CGFloat = 0
            var height: CGFloat = 0
            var clip: Bool = false
            var background: Node?
            
            init(_ renderer: Renderer) {
                self.childrenNode = self.transformNode
                self.id = renderer.items.count
                super.init()
                renderer.items.append(self)
                self.addChild(self.transformNode)
            }

            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
        
        override init(app: GameViewController){
            super.init(app: app)
            Renderer.actions[InActions.SET_WINDOW] = self.setAsWindow
            Renderer.actions[InActions.CREATE_ITEM] = self.create
            Renderer.actions[InActions.SET_ITEM_PARENT] = self.setParent
            Renderer.actions[InActions.SET_ITEM_VISIBLE] = self.setVisible
            Renderer.actions[InActions.SET_ITEM_CLIP] = self.setClip
            Renderer.actions[InActions.SET_ITEM_WIDTH] = self.setWidth
            Renderer.actions[InActions.SET_ITEM_HEIGHT] = self.setHeight
            Renderer.actions[InActions.SET_ITEM_X] = self.setX
            Renderer.actions[InActions.SET_ITEM_Y] = self.setY
            Renderer.actions[InActions.SET_ITEM_Z] = self.setZ
            Renderer.actions[InActions.SET_ITEM_SCALE] = self.setScale
            Renderer.actions[InActions.SET_ITEM_ROTATION] = self.setRotation
            Renderer.actions[InActions.SET_ITEM_OPACITY] = self.setOpacity
            Renderer.actions[InActions.SET_ITEM_BACKGROUND] = self.setBackground
        }
        
        func setAsWindow(reader: Reader) {
            let item = renderer.getItem(reader)!
            app.scene?.removeAllChildren()
            app.scene?.addChild(item)
            item.setScale(0.5)
        }
        
        func create(reader: Reader){
            Node(renderer)
        }
        
        func setParent(reader: Reader){
            let item = renderer.getItem(reader)!
            if let parent = renderer.getItem(reader) {
                (parent as! Node).childrenNode.addChild(item)
            } else {
                item.removeFromParent()
            }
        }
        
        func insertBefore(reader: Reader){
            print("not implemented")
            let item = renderer.getItem(reader)!
            let target = renderer.getItem(reader)!
//            target.parent?.addChild(item)
        }
        
        func setVisible(reader: Reader){
            let item = renderer.getItem(reader)!
            item.hidden = !reader.getBoolean()
        }
        
        func setClip(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = reader.getBoolean()
            assert(item.clip != val)
            item.clip = val
            
            // create crop node
            if item.cropNode == nil {
                let cropNode = SKCropNode()
//                let sprite = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 1000, height: 1000))
                let shape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 1000, height: 1000))
                shape.fillColor = UIColor.blackColor()
                let tex = (app.view as! SKView).textureFromNode(shape)
                let mask = SKSpriteNode(texture: tex)

                mask.alpha = 0
//                cropNode.maskNode = mask
                
                item.cropNode = cropNode
                item.cropNodeMask = mask
            }
            
            // get old and new container
            var oldContainer: SKNode
            var newContainer: SKNode
            if val {
                oldContainer = item.transformNode
                newContainer = item.cropNode!
                oldContainer.addChild(newContainer)
                
//                item.cropNodeMask!.size.width = item.width
//                item.cropNodeMask!.size.height = item.height
            } else {
                oldContainer = item.cropNode!
                newContainer = item.transformNode
                oldContainer.removeFromParent()
            }
            
            // toggle containers
            item.childrenNode = newContainer
            
            // move children to the new container
            for child in oldContainer.children {
                if child != newContainer {
                    child.removeFromParent()
                    newContainer.addChild(child)
                }
            }
        }
        
        func setWidth(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.width = val
            item.position.x = item.x + val / 2
            item.transformNode.position.x = -val / 2
            
            if item.clip {
//                item.cropNodeMask!.size.width = val
            }
        }
        
        func setHeight(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.height = val
            item.position.y = -item.y - val / 2
            item.transformNode.position.y = val / 2
            
            if item.clip {
//                item.cropNodeMask!.size.height = val
            }
        }
        
        func setX(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.x = val
            item.position.x = val + item.width / 2
        }
        
        func setY(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.y = val
            item.position.y = -val - item.height / 2
        }
        
        func setZ(reader: Reader){
            let item = renderer.getItem(reader)!
            let val = CGFloat(reader.getInteger())
            item.zPosition = val
        }
        
        func setScale(reader: Reader){
            let item = renderer.getItem(reader)!
            item.setScale(reader.getFloat())
        }
        
        func setRotation(reader: Reader){
            let item = renderer.getItem(reader)!
            item.zRotation = -reader.getFloat()
        }
        
        func setOpacity(reader: Reader){
            let item = renderer.getItem(reader)!
            let val = CGFloat(reader.getInteger()) / 255
            item.alpha = val
        }
        
        func setBackground(reader: Reader){
            let item = renderer.getItem(reader) as! Node
            let val = renderer.getItem(reader) as? Node
            if item.background != nil {
                item.background?.removeFromParent()
                item.background = nil
            }
            if val != nil {
                item.childrenNode.insertChild(val!, atIndex: 0)
                item.background = val
            }
        }
    }
}
