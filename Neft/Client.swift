import UIKit

class Client {
    let js = Js(name: "neft")
    let reader = Reader()
    
    var actions: Dictionary<InAction, (Reader) -> ()> = [:]
    var customFunctions: Dictionary<String, (args: [Any?]) -> Void> = [:]
    let onDataProcessed = Signal()
    
    private static let EventNilType = 0
    private static let EventBooleanType = 1
    private static let EventFloatType = 2
    private static let EventStringType = 3
    
    var outActions: [Int] = []
    var outBooleans: [Bool] = []
    var outIntegers: [Int] = []
    var outFloats: [CGFloat] = []
    var outStrings: [String] = []
    
    init() {
        self.js.addHandler("transferData", handler: {
            (message: AnyObject) in
            self.reader.reload(message)
            self.onData(self.reader)
        })
        
        actions[InAction.CALL_FUNCTION] = { (reader: Reader) in
            let name = reader.getString()
            let function = self.customFunctions[name]
            
            let argsLength = reader.getInteger()
            var args = [Any?](count: argsLength, repeatedValue: nil)
            
            for i in 0..<argsLength {
                let argType = reader.getInteger()
                switch argType {
                case Client.EventNilType:
                    break
                case Client.EventBooleanType:
                    args[i] = reader.getBoolean()
                case Client.EventFloatType:
                    args[i] = reader.getFloat()
                case Client.EventStringType:
                    args[i] = reader.getString()
                default:
                    break
                }
            }
            
            if function != nil {
                function!(args: args)
            } else {
                print("Native function '\(name)' not found")
            }
        }
    }
    
    func onData(reader: Reader) {
        while let action = reader.getAction() {
            let actionFunc = actions[action]
            if actionFunc != nil {
                actionFunc!(reader)
            } else {
                print("Not implemented action '\(action)'")
            }
        }
        sendData()
        onDataProcessed.emit()
    }
    
    func pushAction(val: OutAction) {
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
    
    func pushEvent(name: String, args: [Any?]?) {
        pushAction(OutAction.EVENT)
        pushString(name)
        if args != nil {
            let length = args!.count
            pushInteger(length)
            for arg in args! {
                if arg == nil {
                    pushInteger(Client.EventNilType)
                } else if arg! is Bool {
                    pushInteger(Client.EventBooleanType)
                    pushBoolean(arg as! Bool)
                } else if arg! is CGFloat {
                    pushInteger(Client.EventFloatType)
                    pushFloat(arg as! CGFloat)
                } else if arg! is String {
                    pushInteger(Client.EventStringType)
                    pushString(arg as! String)
                } else {
                    pushInteger(Client.EventNilType)
                    print("Event can be pushed with a nil, boolean, float or a string, but '\(arg)' given")
                }
            }
        } else {
            pushInteger(0)
        }
    }
    
    func addCustomFunction(name: String, function: (args: [Any?]) -> Void) {
        customFunctions[name] = function
    }
    
    func sendData(var codeBefore: String? = "", _ codeAfter: String = "") {
        if codeBefore == nil {
            codeBefore = ""
        }
        if outActions.count > 0 || codeBefore != "" || codeAfter != "" {
            self.js.runCode("\(codeBefore!);_neft.native.onData(\(outActions), \(outBooleans), \(outIntegers), \(outFloats), \(outStrings));\(codeAfter)")
            outActions.removeAll()
            outIntegers.removeAll()
            outFloats.removeAll()
            outBooleans.removeAll()
            outStrings.removeAll()
        }
    }
}
