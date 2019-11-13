import UIKit
import AVFoundation

fileprivate class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var scannerItem: Extension.Scanner.ScannerItem!
    var captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var lastResult: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.upce, .code39, .code39Mod43, .ean13, .ean8, .code93, .code128, .pdf417, .qr, .aztec, .interleaved2of5, .itf14]
        } else {
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            if stringValue != lastResult {
                lastResult = stringValue
                scannerItem.handleScanned(code: stringValue)
            }
        }

        dismiss(animated: true)
    }
}

extension Extension.Scanner {
    class ScannerItem: NativeItem {
        override class func main() {
            NativeItemBinding()
                .onCreate("Scanner") { ScannerItem() }
                .finalize()
        }

        private var controller = ScannerViewController()

        required init() {
            super.init(itemView: controller.view)
            controller.scannerItem = self
        }

        override internal func updateSize() {
            super.updateSize()
            controller.previewLayer.frame = itemView.layer.bounds
        }

        fileprivate func handleScanned(code: String) {
            pushEvent(event: "scanned", args: [code])
        }
    }
}
