import UIKit
import AVKit
import AVFoundation

extension Extension.Video {
    class VideoItem: NativeItem {
        override class func main() {
            NativeItemBinding()
                .onCreate("Video") { VideoItem() }
                .onSet("source") { (item, val: String) in item.setSource(val) }
                .onSet("loop") { (item, val: Bool) in item.setLoop(val) }
                .onCall("start") { (item) in item.start() }
                .onCall("stop") { (item) in item.stop() }
                .finalize()
        }

        var player: AVPlayer?
        var layer: AVPlayerLayer?
        var loop = false
        var running = false

        override var width: CGFloat {
            didSet {
                super.width = width
                updatePlayerSize()
            }
        }

        override var height: CGFloat {
            didSet {
                super.height = height
                updatePlayerSize()
            }
        }

        init() {
            super.init(itemView: UIView())
        }

        private func updatePlayerSize() {
            layer?.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }

        @objc func playerItemDidReachEnd(notification: Notification) {
            if loop {
                player?.seek(to: CMTime.zero)
                player?.play()
            }
        }

        func setSource(_ val: String) {
            layer?.removeFromSuperlayer()
            player = nil
            layer = nil

            let url = URL(string: val)
            guard url != nil else { return }

            player = AVPlayer(url: url!)
            layer = AVPlayerLayer(player: player)
            updatePlayerSize()
            itemView.layer.addSublayer(layer!)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(playerItemDidReachEnd(notification:)),
                name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                object: player!.currentItem
            )

            if running {
                player?.play()
            }
        }

        func setLoop(_ val: Bool) {
            loop = val
        }

        func start() {
            running = true
            player?.seek(to: CMTime.zero)
            player?.play()
        }

        func stop() {
            running = false
            player?.pause()
        }
    }
}
