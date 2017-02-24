import UIKit

extension Extension.Slider {
    class SliderItem: NativeItem {
        override class var name: String { return "Slider" }

        override class func register() {
            onCreate() {
                return SliderItem()
            }

            onSet("value") {
                (item: SliderItem, val: CGFloat) in
                item.sliderView.value = Float(val)
            }

            onSet("thumbColor") {
                (item: SliderItem, val: UIColor?) in
                item.sliderView.thumbTintColor = val
            }

            onSet("minTrackColor") {
                (item: SliderItem, val: UIColor?) in
                item.sliderView.minimumTrackTintColor = val
            }

            onSet("maxTrackColor") {
                (item: SliderItem, val: UIColor?) in
                item.sliderView.maximumTrackTintColor = val
            }

            onSet("minValue") {
                (item: SliderItem, val: CGFloat) in
                item.sliderView.minimumValue = Float(val)
            }

            onSet("maxValue") {
                (item: SliderItem, val: CGFloat) in
                item.sliderView.maximumValue = Float(val)
            }

            onCall("setValueAnimated") {
                (item: SliderItem, args: [Any?]) in
                let val = Float(args[0] as! CGFloat)
                item.sliderView.setValue(val, animated: true)
            }
        }

        var sliderView: UISlider {
            return itemView as! UISlider
        }

        init() {
            super.init(itemView: UISlider())

            sliderView.addTarget(
                self,
                action: #selector(onValueChange(sliderState:)),
                for: .valueChanged
            )
        }

        @objc
        private func onValueChange(sliderState: UISlider) {
            let val = CGFloat(sliderState.value)
            pushEvent(event: "valueChange", args: [val])
        }
    }
}
