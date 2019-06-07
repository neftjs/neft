import Foundation

class Reader {
    private var data: ClientUpdateMessage?
    private var actionsIndex = 0
    private var booleansIndex = 0
    private var integersIndex = 0
    private var floatsIndex = 0
    private var stringsIndex = 0

    func reload(_ message: ClientUpdateMessage) {
        data = message
        actionsIndex = 0
        booleansIndex = 0
        integersIndex = 0
        floatsIndex = 0
        stringsIndex = 0
    }

    func getAction() -> InAction? {
        if actionsIndex >= data!.actions.count {
            return nil
        }
        actionsIndex += 1
        return InAction(rawValue: data!.actions[actionsIndex - 1])
    }

    func getBoolean() -> Bool {
        booleansIndex += 1
        return data!.booleans[booleansIndex - 1]
    }

    func getInteger() -> Int {
        integersIndex += 1
        return data!.integers[integersIndex - 1]
    }

    func getFloat() -> CGFloat {
        floatsIndex += 1
        return data!.floats[floatsIndex - 1]
    }

    func getString() -> String {
        stringsIndex += 1
        return data!.strings[stringsIndex - 1]
    }

}
