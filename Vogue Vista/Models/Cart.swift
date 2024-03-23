import Foundation

struct Cart: Codable, Identifiable {
    let id: Int
    var items: [CartItem]
}
