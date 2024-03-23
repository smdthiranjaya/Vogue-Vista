
import Foundation

struct CartItem: Codable, Identifiable {
    let id: Int
    let productId: Int
    let color: String
    let size: String
    let quantity: Int
    let price: Double
}
