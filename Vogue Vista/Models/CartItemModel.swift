
import Foundation

struct CartItem: Codable, Identifiable {
    let id: Int
    let product_id: Int
    let color: String
    let size: String
    let quantity: Int
    let price: String
    let name: String
    let created_at: String
    let cart_id: Int
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id, product_id, color, size, quantity, price, name, created_at, cart_id
        case imageUrl = "imageurl"
    }
}
