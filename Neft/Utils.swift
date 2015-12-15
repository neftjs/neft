import SpriteKit

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

func hexColorToUIColor(hexInt: Int) -> UIColor {
    let hex     = UInt(bitPattern: hexInt)
    let divisor = CGFloat(255)
    let red     = CGFloat(hex >> 24)        / divisor
    let green   = CGFloat(hex >> 16 & 0xFF) / divisor
    let blue    = CGFloat(hex >> 8  & 0xFF) / divisor
    let alpha   = CGFloat(hex       & 0xFF) / divisor
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}