import Foundation

struct Order: Codable, Identifiable {
    var id: Int
    var userId: Int
    var items: [CartItem]
    var address: String
    var cardNumber: String
    var totalAmount: Double
    var createdAt: String
    var status: String

    private enum CodingKeys: String, CodingKey {
        case id
        case userId = "userId"
        case items
        case address
        case cardNumber = "cardNumber"
        case totalAmount = "totalAmount"
        case createdAt = "createdAt"
        case status
    }
}
