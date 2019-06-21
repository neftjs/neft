import UIKit

extension Extension.Slider {
    class SliderItem: NativeItem {
        override class func main() {
            NativeItemBinding()
                .onCreate("Slier") { SliderItem() }
                .onSet("value") { (item, val: CGFloat) in item.setValue(val) }
                .onSet("thumbColor") { (item, val: UIColor?) in item.setThumbColor(val) }
                .onSet("minTrackColor") { (item, val: UIColor?) in item.setMinTrackColor(val) }
                .onSet("maxTrackColor") { (item, val: UIColor?) in item.setMaxTrackColor(val) }
                .onSet("minValue") { (item, val: CGFloat) in item.setMinValue(val) }
                .onSet("maxValue") { (item, val: CGFloat) in item.setMaxValue(val) }
                .onCall("setValueAnimated") {
                    (item, args: [Any?]) in
                    let val = args[0] as! CGFloat
                    item.setValueAnimated(val)
                }
                .finalize()
        }

        var sliderView = UISlider()

        init() {
            super.init(itemView: sliderView)

            sliderView.addTarget(
                self,
                action: #selector(onValueChange(sliderState:)),
                for: .valueChanged
            )
        }

        func setValue(_ val: CGFloat) {
            sliderView.value = Float(val)
        }

        func setThumbColor(_ val: UIColor?) {
            sliderView.thumbTintColor = val
        }

        func setMinTrackColor(_ val: UIColor?) {
            sliderView.minimumTrackTintColor = val
        }

        func setMaxTrackColor(_ val: UIColor?) {
            sliderView.maximumTrackTintColor = val
        }

        func setMinValue(_ val: CGFloat) {
            sliderView.minimumValue = Float(val)
        }

        func setMaxValue(_ val: CGFloat) {
            sliderView.maximumValue = Float(val)
        }

        func setValueAnimated(_ val: CGFloat) {
            sliderView.setValue(Float(val), animated: true)
        }

        @objc
        private func onValueChange(sliderState: UISlider) {
            let val = CGFloat(sliderState.value)
            pushEvent(event: "valueChange", args: [val])
        }
    }
}
