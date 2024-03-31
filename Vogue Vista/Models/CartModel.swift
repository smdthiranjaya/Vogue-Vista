import Foundation

struct Cart: Codable {
    let id: Int
    let user_id: Int
    let created_at: String
    let items: [CartItem]
}
