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
    var isSpecialOffer: Bool?
    var specialOfferSince: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, price, category, color, size
        case imageUrl = "imageurl"
        case isSpecialOffer = "is_special_offer"
        case specialOfferSince = "special_offer_since"
        case createdAt = "created_at"
    }
}
