
import SwiftUI

class ShoppingCartViewModel: ObservableObject {
    @Published var cart: Cart?
    @Published var items: [CartItem] = []

    struct ShoppingCartResponse: Codable {
        let cart: Cart
        let items: [CartItem]
    }
    
    let baseURL = "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com"
    
    func fetchCart() {
        guard let userId = UserDefaults.standard.object(forKey: "userId") as? Int else {
            print("User ID not found")
            return
        }
        
        guard let url = URL(string: "\(baseURL)/cart/\(userId)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching cart: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                // Decode into the ShoppingCartResponse structure
                let decodedResponse = try JSONDecoder().decode(ShoppingCartResponse.self, from: data)
                DispatchQueue.main.async {
                    // Assuming the 'cart' property in ShoppingCartResponse is what you were referring to with 'Cart'
                    self.cart = decodedResponse.cart
                    // Assuming the 'items' property in ShoppingCartResponse corresponds to 'Items'
                    self.items = decodedResponse.items
                }
            } catch {
                print("Failed to decode cart: \(error.localizedDescription)")
            }
        }.resume()
    }

}
