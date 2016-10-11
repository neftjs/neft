import UIKit

class Reader {
    fileprivate var actions = NSArray()
    fileprivate var booleans = NSArray()
    fileprivate var integers = NSArray()
    fileprivate var floats = NSArray()
    fileprivate var strings = NSArray()

    fileprivate var actionsIndex = 0
    fileprivate var booleansIndex = 0
    fileprivate var integersIndex = 0
    fileprivate var floatsIndex = 0
    fileprivate var stringsIndex = 0

    func reload(_ body: AnyObject){
        let dict = body as! NSDictionary
        self.actions = dict.object(forKey: "actions") as! NSArray
        self.booleans = dict.object(forKey: "booleans") as! NSArray
        self.integers = dict.object(forKey: "integers") as! NSArray
        self.floats = dict.object(forKey: "floats") as! NSArray
        self.strings = dict.object(forKey: "strings") as! NSArray

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
