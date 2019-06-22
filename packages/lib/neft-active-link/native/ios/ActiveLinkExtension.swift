import UIKit

fileprivate let binding = NativeBinding("ActiveLink")

extension Extension.ActiveLink {
    static func register() {
        binding
            .onCall("web") { (args: [Any?]) in
                web(url: args[0] as? String)
            }
            .onCall("mailto", { (args: [Any?]) in
                mailto(
                    address: args[0] as? String,
                    subject: args[1] as? String
                )
            })
            .onCall("tel", { (args: [Any?]) in
                tel(number: args[0] as? String)
            })
            .onCall("geo", { (args: [Any?]) in
                geo(
                    latitude: (args[0] as? Number)?.float(),
                    longitude: (args[1] as? Number)?.float(),
                    address: args[2] as? String
                )
            })
            .finalize()
    }

    private static func web(url: String?) {
        if let url = URL(string: url ?? "") {
            UIApplication.shared.openURL(url)
        }
    }

    private static func mailto(address: String?, subject: String?) {
        if let url = URL(string: "mailto:\(address ?? "")?subject=\(subject ?? "")") {
            UIApplication.shared.openURL(url)
        }
    }

    private static func tel(number: String?) {
        let urlNumber = number?.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(urlNumber ?? "")") {
            UIApplication.shared.openURL(url)
        }
    }

    private static func geo(latitude: CGFloat?, longitude: CGFloat?, address: String?) {
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
