import Foundation

struct ClientUpdateMessage {
    let actions: [Int]
    let booleans: [Bool]
    let floats: [CGFloat]
    let integers: [Int]
    let strings: [String]
}
