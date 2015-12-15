import UIKit
import SpriteKit

class Renderer {
    class BaseType {
        let app: GameViewController
        let js: Js
        let renderer: Renderer
        
        init(app: GameViewController){
            self.app = app
            self.renderer = app.renderer!
            self.js = renderer.js
        }
    }
    
    class Reader {
        private var actions = NSArray()
        private var booleans = NSArray()
        private var integers = NSArray()
        private var floats = NSArray()
        private var strings = NSArray()
        
        private var actionsIndex = 0
        private var booleansIndex = 0
        private var integersIndex = 0
        private var floatsIndex = 0
        private var stringsIndex = 0
        
        func reload(body: AnyObject){
            let dict = body as! NSDictionary
            self.actions = dict.objectForKey("actions") as! NSArray
            self.booleans = dict.objectForKey("booleans") as! NSArray
            self.integers = dict.objectForKey("integers") as! NSArray
            self.floats = dict.objectForKey("floats") as! NSArray
            self.strings = dict.objectForKey("strings") as! NSArray
            
            actionsIndex = 0
            booleansIndex = 0
            integersIndex = 0
            floatsIndex = 0
            stringsIndex = 0
        }
        
        func getAction() -> InActions? {
            if (actionsIndex >= actions.count){
                return nil
            }
            return InActions(rawValue: actions[actionsIndex++] as! Int)
        }
        
        func getBoolean() -> Bool {
            return booleans[booleansIndex++] as! Bool
        }
        
        func getInteger() -> Int {
            return integers[integersIndex++] as! Int
        }
        
        func getFloat() -> CGFloat {
            return floats[floatsIndex++] as! CGFloat
        }
        
        func getString() -> String {
            return strings[stringsIndex++] as! String
        }
    }
    
    private let app: GameViewController
    let js = Js(name: "neft")
    static var actions: Dictionary<InActions, (Reader) -> ()> = [:]
    
    var items: [SKNode] = []
    
    let reader = Reader()
    var outActions: [Int] = []
    var outBooleans: [Bool] = []
    var outIntegers: [Int] = []
    var outFloats: [CGFloat] = []
    var outStrings: [String] = []
    
    enum InActions: Int {
        case
        SET_WINDOW = 0,
        
        CREATE_ITEM,
        SET_ITEM_PARENT,
        INSERT_ITEM_BEFORE,
        SET_ITEM_VISIBLE,
        SET_ITEM_CLIP,
        SET_ITEM_WIDTH,
        SET_ITEM_HEIGHT,
        SET_ITEM_X,
        SET_ITEM_Y,
        SET_ITEM_Z,
        SET_ITEM_SCALE,
        SET_ITEM_ROTATION,
        SET_ITEM_OPACITY,
        SET_ITEM_BACKGROUND,
        
        CREATE_IMAGE,
        SET_IMAGE_SOURCE,
        SET_IMAGE_SOURCE_WIDTH,
        SET_IMAGE_SOURCE_HEIGHT,
        SET_IMAGE_FILL_MODE,
        SET_IMAGE_OFFSET_X,
        SET_IMAGE_OFFSET_Y,
        
        CREATE_TEXT,
        SET_TEXT,
        SET_TEXT_WRAP,
        UPDATE_TEXT_CONTENT_SIZE,
        SET_TEXT_COLOR,
        SET_TEXT_LINE_HEIGHT,
        SET_TEXT_FONT_FAMILY,
        SET_TEXT_FONT_PIXEL_SIZE,
        SET_TEXT_FONT_WORD_SPACING,
        SET_TEXT_FONT_LETTER_SPACING,
        SET_TEXT_ALIGNMENT_HORIZONTAL,
        SET_TEXT_ALIGNMENT_VERTICAL,
        
        LOAD_FONT,
        
        CREATE_RECTANGLE,
        SET_RECTANGLE_COLOR,
        SET_RECTANGLE_RADIUS,
        SET_RECTANGLE_BORDER_COLOR,
        SET_RECTANGLE_BORDER_WIDTH
    }
    
    enum OutActions: Int {
        case
        SCREEN_SIZE = 0,
        SCREEN_ORIENTATION,
        NAVIGATOR_LANGUAGE,
        NAVIGATOR_ONLINE,
        DEVICE_PIXEL_RATIO,
        DEVICE_IS_PHONE,
        POINTER_PRESS,
        POINTER_RELEASE,
        POINTER_MOVE,
        IMAGE_SIZE,
        TEXT_SIZE,
        FONT_LOAD
    }
    
    init(app: GameViewController) {
        self.app = app
        
        self.js.addHandler("updateView", handler: {
            (message: AnyObject) in
            self.reader.reload(message)
            self.updateView(self.reader)
        })
    }
    
    func load() {
        self.js.runScript("neft")
        
        Renderer.Item.init(app: app)
        Renderer.Image.init(app: app)
        Renderer.Text.init(app: app)
        Renderer.Device.init(app: app)
        Renderer.Screen.init(app: app)
        Renderer.Navigator.init(app: app)
        Renderer.Rectangle.init(app: app)
    }
    
    func getItem(key: Int) -> SKNode? {
        return key == -1 ? nil : items[key]
    }
    
    func getItem(reader: Reader) -> SKNode? {
        let id = reader.getInteger()
        return id == -1 ? nil : items[id]
    }
    
    func updateView(reader: Reader) {
        while let action = reader.getAction() {
            let actionFunc = Renderer.actions[action]
            actionFunc!(reader)
        }
        self.sendData()
    }
    
    func pushAction(val: OutActions) {
        outActions.append(val.rawValue)
    }
    
    func pushBoolean(val: Bool) {
        outBooleans.append(val)
    }
    
    func pushInteger(val: Int) {
        outIntegers.append(val)
    }
    
    func pushFloat(val: CGFloat) {
        outFloats.append(val)
    }
    
    func pushString(val: String) {
        outStrings.append(val)
    }
    
    func sendData(var codeBefore: String? = "", _ codeAfter: String = "") {
        if codeBefore == nil {
            codeBefore = ""
        }
        if outActions.count > 0 || codeBefore != "" || codeAfter != "" {
            self.js.runCode("\(codeBefore!);_neft.renderer.onUpdateView(\(outActions), \(outBooleans), \(outIntegers), \(outFloats), \(outStrings));\(codeAfter)")
            outActions.removeAll()
            outIntegers.removeAll()
            outFloats.removeAll()
            outBooleans.removeAll()
            outStrings.removeAll()
        }
    }
    
    func callAnimationFrame() {
        self.sendData(nil, "_neft.onAnimationFrame()")
    }
}