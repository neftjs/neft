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

        app.client.addCustomFunction("NeftActiveLink/geo") {
            (args: [Any?]) in
            let latitude = (args[0] as? Number)?.float()
            let longitude = (args[1] as? Number)?.float()
            let address = args[2] as? String
            geo(latitude, longitude, address)
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

    private static func geo(_ latitude: CGFloat?, _ longitude: CGFloat?, _ address: String?) {
        var url = URLComponents(string: "http://maps.apple.com/")
        var query: [URLQueryItem] = []
        if address != nil {
            query.append(URLQueryItem(name: "q", value: address ?? ""))
        }
        if latitude != nil && longitude != nil {
            query.append(URLQueryItem(name: "sll", value: "\(latitude ?? 0),\(longitude ?? 0)"))
        }
        url?.queryItems = query

        if let appUrl = url?.url {
            UIApplication.shared.openURL(appUrl)
        }
    }
}
