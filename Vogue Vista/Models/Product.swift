import Foundation

struct Product: Identifiable, Decodable {
    var id: Int
    var name: String
    var description: String
    var price: String
    var category: String
    var color: String
    var size: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, price, category, color, size
        case imageUrl = "imageurl"
    }
}
