import UIKit

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

    func getAction() -> InAction? {
        if (actionsIndex >= actions.count){
            return nil
        }
        actionsIndex += 1
        return InAction(rawValue: actions[actionsIndex - 1] as! Int)
    }

    func getBoolean() -> Bool {
        booleansIndex += 1
        return booleans[booleansIndex - 1] as! Bool
    }

    func getInteger() -> Int {
        integersIndex += 1
        return integers[integersIndex - 1] as! Int
    }

    func getFloat() -> CGFloat {
        floatsIndex += 1
        return floats[floatsIndex - 1] as! CGFloat
    }

    func getString() -> String {
        stringsIndex += 1
        return strings[stringsIndex - 1] as! String
    }
}
