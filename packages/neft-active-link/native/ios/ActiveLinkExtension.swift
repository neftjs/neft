import UIKit

extension Extension.ActiveLink {
    static let app = App.getApp()

    static func register() {
        app.client.addCustomFunction("NeftActiveLink/mailto") {
            (args: [Any?]) in
            let address = args[0] as? String
            let subject = args[1] as? String
            mailto(address: address, subject: nil)
        }

        app.client.addCustomFunction("NeftActiveLink/tel") {
            (args: [Any?]) in
            let number = args[0] as? String
            tel(number: number)
        }
    }

    private static func mailto(address: String?, subject: String?) {
        if let url = URL(string: "mailto:\(address ?? "")?subject=\(subject ?? "")") {
            UIApplication.shared.openURL(url)
        }
    }

    private static func tel(number: String?) {
        if let url = URL(string: "tel:\(number ?? "")") {
            UIApplication.shared.openURL(url)
        }
    }
}
