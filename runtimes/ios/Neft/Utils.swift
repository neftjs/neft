import UIKit

func thread(_ background: @escaping () -> Void, _ completion: (() -> Void)? = nil) {
    let priority = DispatchQueue.GlobalQueuePriority.default
    DispatchQueue.global(priority: priority).async {
        background()
        
        DispatchQueue.main.async {
            if completion != nil {
                completion!()
            }
        }
    }
}

func thread<T>(_ background: @escaping (_ completion: (_ param: T?) -> Void) -> Void, _ completion: ((T?) -> Void)? = nil) {
    let priority = DispatchQueue.GlobalQueuePriority.default
    DispatchQueue.global(priority: priority).async {
        background() {
            (result: T?) in
            DispatchQueue.main.async {
                if completion != nil {
                    completion!(result)
                }
            }
        }
    }
}

class Signal {
    fileprivate var listeners: [(_ arg: Any?) -> Void] = []
    
    func connect(_ listener: @escaping (_ arg: Any?) -> Void) {
        listeners.append(listener)
    }
    
    func emit(_ arg: Any? = nil) {
        for listener in listeners {
            listener(arg)
        }
    }
}

class Color {
    static fileprivate let colorDivisor: CGFloat = 255
    static fileprivate let colorSpace = CGColorSpaceCreateDeviceRGB()
    static fileprivate var colorComponents: [CGFloat] = Array(repeating: 0, count: 4)
    
    static func hexColorToCGColor(_ hex: Int) -> CGColor {
        colorComponents[0] = CGFloat(hex >> 24)        / colorDivisor
        colorComponents[1] = CGFloat(hex >> 16 & 0xFF) / colorDivisor
        colorComponents[2] = CGFloat(hex >> 8  & 0xFF) / colorDivisor
        colorComponents[3] = CGFloat(hex       & 0xFF) / colorDivisor
        return CGColor(colorSpace: colorSpace, components: colorComponents)!
    }
    
    static func hexColorToUIColor(_ hex: Int) -> UIColor {
        return UIColor(cgColor: hexColorToCGColor(hex))
    }
}
