import UIKit

func thread(background: () -> Void, completion: (() -> Void)? = nil) {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
        background()
        
        dispatch_async(dispatch_get_main_queue()) {
            if completion != nil {
                completion!()
            }
        }
    }
}

func thread<T>(background: (completion: (T) -> Void) -> Void, completion: ((T) -> Void)? = nil) {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
        background() {
            (result: T) in
            dispatch_async(dispatch_get_main_queue()) {
                if completion != nil {
                    completion!(result)
                }
            }
        }
    }
}

class Signal {
    private var listeners: [(arg: Any?) -> Void] = []
    
    func connect(listener: (arg: Any?) -> Void) {
        listeners.append(listener)
    }
    
    func emit(arg: Any? = nil) {
        for listener in listeners {
            listener(arg: arg)
        }
    }
}

class Color {
    static private let colorDivisor: CGFloat = 255
    static private let colorSpace = CGColorSpaceCreateDeviceRGB()
    static private var colorComponents: [CGFloat] = Array(count: 4, repeatedValue: 0)
    
    static func hexColorToCGColor(hexInt: Int) -> CGColorRef {
        let hex = UInt(bitPattern: hexInt)
        colorComponents[0] = CGFloat(hex >> 24)        / colorDivisor
        colorComponents[1] = CGFloat(hex >> 16 & 0xFF) / colorDivisor
        colorComponents[2] = CGFloat(hex >> 8  & 0xFF) / colorDivisor
        colorComponents[3] = CGFloat(hex       & 0xFF) / colorDivisor
        return CGColorCreate(colorSpace, colorComponents)!
    }
    
    static func hexColorToUIColor(hexInt: Int) -> UIColor {
        return UIColor(CGColor: hexColorToCGColor(hexInt))
    }
}