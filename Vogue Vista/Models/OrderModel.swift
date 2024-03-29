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
        case userId = "userId" // Modified to match the server's expectation
        case items
        case address
        case cardNumber = "cardNumber" // Assuming the server expects camelCase
        case totalAmount = "totalAmount" // Assuming the server expects camelCase
        case createdAt = "createdAt" // Assuming the server expects camelCase
        case status
    }
}
