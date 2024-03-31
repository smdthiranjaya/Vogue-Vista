import SwiftUI

class ShoppingCartViewModel: ObservableObject {
    @Published var cart: Cart?
    @Published var items: [CartItem] = []
    
    let baseURL = URL(string: AppConfiguration.serverURL)!
    
    struct RemoveItemResponse: Decodable {
        let message: String
        let item: RemovedItem?
    }
    
    struct RemovedItem: Decodable {
        let id: Int
    }
    
    
    var totalPrice: String {
        let total = items.reduce(0.0) { $0 + (Double($1.price) ?? 0.0) * Double($1.quantity) }
        return String(format: "%.2f", total)
    }
    
    
    func fetchCart() {
        guard let userId = UserDefaults.standard.object(forKey: "userId") as? Int else {
            print("User ID not found")
            return
        }
        
        guard let url = URL(string: "\(baseURL)/cart/\(userId)") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    print("Error fetching cart: \(error?.localizedDescription ?? "Unknown error")")
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(Cart.self, from: data)
                DispatchQueue.main.async {
                    self?.cart = decodedResponse
                    self?.items = decodedResponse.items
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to decode cart: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func removeItemFromCart(itemId: Int) {
        guard let url = URL(string: "\(baseURL)/cart/item/\(itemId)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    print("Error removing item: \(error?.localizedDescription ?? "Unknown error")")
                }
                return
            }
            
            do {
                let removedItemResponse = try JSONDecoder().decode(RemoveItemResponse.self, from: data)
                DispatchQueue.main.async {
                    print("Item removed: \(removedItemResponse.message)")
                    self?.fetchCart()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to decode response: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
}
