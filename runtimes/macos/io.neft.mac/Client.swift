import Cocoa

class Client {
    let reader = Reader()
    let script: Script

    var actions: [InAction: (Reader) -> ()] = [:]
    var customFunctions: [String: (_ args: [Any?]) -> Void] = [:]
    var ready = false

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

    init(script: Script) {
        self.script = script

        script.onClientUpdateMessage = self.onUpdateMessage

        actions[InAction.callFunction] = { (reader: Reader) in
            let name = reader.getString()
            let function = self.customFunctions[name]

            let argsLength = reader.getInteger()
            var args = [Any?](repeating: nil, count: argsLength)

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
                function!(args)
            } else {
                print("Native function '\(name)' not found")
            }
        }
    }

    func onUpdateMessage(_ message: ClientUpdateMessage) {
        reader.reload(message)
        onData(reader)
    }

    func updateViews(_ transaction: () -> Void) {
        // No clue why Cocoa is so stupid to animate all changes by default.
        // Let's disable it.
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        transaction()
        CATransaction.commit()
    }

    func onData(_ reader: Reader) {
        updateViews {
            while let action = reader.getAction() {
                let actionFunc = self.actions[action]
                if actionFunc != nil {
                    actionFunc!(reader)
                } else {
                    print("Not implemented action '\(action)'")
                }
            }
        }

        sendData()

        // update layer transformations when all frames are set;
        // changing frame resets transform on a layer;
        // better solution could be custom NSView see https://gist.github.com/jwilling/8162440
        DispatchQueue.main.async {
            self.updateViews {
                Item.updateItemTransforms()
            }
        }
    }

    private func pushIntoArray<T>(_ arr: inout [T], index: Int, val: T) {
        if arr.count > index {
            arr[index] = val
        } else {
            arr.append(val)
        }
    }

    private func pushAction(_ val: OutAction) {
        pushIntoArray(&outActions, index: outActionsIndex, val: val.rawValue)
        outActionsIndex += 1

        if outActionsIndex == 1 && ready {
            DispatchQueue.main.async {
                self.sendData()
            }
        }
    }

    private func pushBoolean(_ val: Bool) {
        pushIntoArray(&outBooleans, index: outBooleansIndex, val: val)
        outBooleansIndex += 1
    }

    private func pushInteger(_ val: Int) {
        pushIntoArray(&outIntegers, index: outIntegersIndex, val: val)
        outIntegersIndex += 1
    }

    private func pushFloat(_ val: CGFloat) {
        pushIntoArray(&outFloats, index: outFloatsIndex, val: val)
        outFloatsIndex += 1
    }

    private func pushString(_ val: String) {
        pushIntoArray(&outStrings, index: outStringsIndex, val: val)
        outStringsIndex += 1
    }

    func pushEvent(_ name: String, args: [Any?]?) {
        pushAction(OutAction.event)
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

    func addCustomFunction(_ name: String, function: @escaping (_ args: [Any?]) -> Void) {
        customFunctions[name] = function
    }

    /**
     Removes all elements after the given length.
     */
    private func cutDataArray<T>(_ arr: inout [T], length: Int) {
        if arr.count > length {
            arr.removeSubrange(length..<arr.count)
        }
    }

    func sendData(_ completion: (() -> Void)? = nil) {
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

        script.runCode("__macos__.clientDataHandler(\(outActions), \(self.outBooleans), \(self.outIntegers), \(self.outFloats), \(self.outStrings))", completion)
    }

    func onAction(_ action: InAction, _ handler: @escaping (Reader) -> Void) {
        App.getApp().client.actions[action] = {
            (reader: Reader) in
            handler(reader)
        }
    }

    func onAction(_ action: InAction, _ handler: @escaping () -> Void) {
        onAction(action) {
            (reader: Reader) in
            handler()
        }
    }

    func pushAction(_ action: OutAction, _ args: [Any]) {
        pushAction(action)
        for arg in args {
            if arg is Bool {
                pushBoolean(arg as! Bool)
            } else if arg is CGFloat {
                pushFloat(arg as! CGFloat)
            } else if arg is Int {
                pushInteger(arg as! Int)
            } else if arg is String {
                pushString(arg as! String)
            } else {
                fatalError("Action can be pushed with Bool, CGFloat or String, but '\(arg)' given")
            }
        }
    }

    func pushAction(_ action: OutAction, _ args: Any...) {
        pushAction(action, args)
    }

    func destroy() {
        actions.removeAll()
    }
}
