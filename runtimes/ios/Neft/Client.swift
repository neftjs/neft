import UIKit

class Client {
    let js = JS()
    let reader = Reader()

    var actions: Dictionary<InAction, (Reader) -> ()> = [:]
    var customFunctions: Dictionary<String, (args: [Any?]) -> Void> = [:]
    let onDataProcessed = Signal()

    private static let EventNilType = 0
    private static let EventBooleanType = 1
    private static let EventFloatType = 2
    private static let EventStringType = 3

    var outActions: [Int] = []
    private var outActionsIndex = 0
    var outBooleans: [Bool] = []
    private var outBooleansIndex = 0
    var outIntegers: [Int] = []
    private var outIntegersIndex = 0
    var outFloats: [CGFloat] = []
    private var outFloatsIndex = 0
    var outStrings: [String] = []
    private var outStringsIndex = 0

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

    private func pushIntoArray<T>(inout arr: [T], index: Int, val: T) {
        if arr.count > index {
            arr[index] = val
        } else {
            arr.append(val)
        }
    }

    func reload(bundle: String) {
        self.reader.reload([
            "actions": [],
            "booleans": [],
            "integers": [],
            "floats": [],
            "strings": []
        ])
        outActionsIndex = 0
        outIntegersIndex = 0
        outFloatsIndex = 0
        outBooleansIndex = 0
        outStringsIndex = 0
        self.js.runCode(bundle)
    }

    func pushAction(val: OutAction) {
        pushIntoArray(&outActions, index: outActionsIndex, val: val.rawValue)
        outActionsIndex += 1
    }

    func pushBoolean(val: Bool) {
        pushIntoArray(&outBooleans, index: outBooleansIndex, val: val)
        outBooleansIndex += 1
    }

    func pushInteger(val: Int) {
        pushIntoArray(&outIntegers, index: outIntegersIndex, val: val)
        outIntegersIndex += 1
    }

    func pushFloat(val: CGFloat) {
        pushIntoArray(&outFloats, index: outFloatsIndex, val: val)
        outFloatsIndex += 1
    }

    func pushString(val: String) {
        pushIntoArray(&outStrings, index: outStringsIndex, val: val)
        outStringsIndex += 1
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
                    print("Event can be pushed with a nil, Bool, CGFloat or a String, but '\(arg)' given")
                }
            }
        } else {
            pushInteger(0)
        }
    }

    func addCustomFunction(name: String, function: (args: [Any?]) -> Void) {
        customFunctions[name] = function
    }

    /**
     Removes all elements after the given length.
     */
    private func cutDataArray<T>(inout arr: [T], length: Int) {
        if arr.count > length {
            arr.removeRange(length..<arr.count)
        }
    }

    func sendData() {
        guard outActionsIndex > 0 else { return; }

        cutDataArray(&outActions, length: outActionsIndex)
        cutDataArray(&outBooleans, length: outBooleansIndex)
        cutDataArray(&outIntegers, length: outIntegersIndex)
        cutDataArray(&outFloats, length: outFloatsIndex)
        cutDataArray(&outStrings, length: outStringsIndex)

        outActionsIndex = 0
        outIntegersIndex = 0
        outFloatsIndex = 0
        outBooleansIndex = 0
        outStringsIndex = 0

        js.proxy.dataCallback.callWithArguments([outActions, outBooleans, outIntegers, outFloats, outStrings])
    }
}
