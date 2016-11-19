import UIKit

extension Extension.DefaultStyles {
    class StepperItem: NativeItem {
        override class var name: String { return "DSStepper" }

        override class func register() {
            onCreate() {
                return StepperItem()
            }

            onSet("value") {
                (item: StepperItem, val: CGFloat) in
                item.stepperView.value = Double(val)
            }

            onSet("color") {
                (item: StepperItem, val: UIColor?) in
                item.stepperView.tintColor = val ?? App.getApp().view.tintColor
            }

            onSet("minValue") {
                (item: StepperItem, val: CGFloat) in
                item.stepperView.minimumValue = Double(val)
            }

            onSet("maxValue") {
                (item: StepperItem, val: CGFloat) in
                item.stepperView.maximumValue = Double(val)
            }

            onSet("stepValue") {
                (item: StepperItem, val: CGFloat) in
                item.stepperView.stepValue = Double(val)
            }
        }

        var stepperView: UIStepper {
            return view as! UIStepper
        }

        override init(view: UIView = UIStepper()) {
            super.init(view: view)

            stepperView.addTarget(
                self,
                action: #selector(onValueChange(stepperState:)),
                for: .valueChanged
            )
        }

        @objc
        private func onValueChange(stepperState: UIStepper) {
            let val = CGFloat(stepperView.value)
            pushEvent(event: "valueChange", args: [val])
        }
    }
}
