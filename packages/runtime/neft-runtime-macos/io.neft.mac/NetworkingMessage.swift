import Foundation

struct NetworkingMessage {
    let id: Int
    let uri: String
    let method: String
    let headers: [String: String]
    let data: String?
}
