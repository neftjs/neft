import UIKit

extension Extension.Stepper {
    class StepperItem: NativeItem {
        override class func main() {
            NativeItemBinding()
                .onCreate("Stepper") { StepperItem() }
                .onSet("value") { (item, val: CGFloat) in item.setValue(val) }
                .onSet("color") { (item, val: UIColor?) in item.setColor(val) }
                .onSet("minValue") { (item, val: CGFloat) in item.setMinValue(val) }
                .onSet("maxValue") { (item, val: CGFloat) in item.setMaxValue(val) }
                .onSet("stepValue") { (item, val: CGFloat) in item.setStepValue(val) }
                .finalize()
        }

        var stepperView = UIStepper()

        init() {
            super.init(itemView: stepperView)

            stepperView.addTarget(
                self,
                action: #selector(onValueChange(stepperState:)),
                for: .valueChanged
            )
        }

        func setValue(_ val: CGFloat) {
            stepperView.value = Double(val)
        }

        func setColor(_ val: UIColor?) {
            stepperView.tintColor = val ?? App.getApp().view.tintColor
        }

        func setMinValue(_ val: CGFloat) {
            stepperView.minimumValue = Double(val)
        }

        func setMaxValue(_ val: CGFloat) {
            stepperView.maximumValue = Double(val)
        }

        func setStepValue(_ val: CGFloat) {
            stepperView.stepValue = Double(val)
        }

        @objc
        private func onValueChange(stepperState: UIStepper) {
            let val = CGFloat(stepperView.value)
            pushEvent(event: "valueChange", args: [val])
        }
    }
}
