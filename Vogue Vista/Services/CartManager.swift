import Foundation

class CartManager {
    let baseURL = "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com" // Replace with your actual base URL
    
    func addToCart(userId: Int, productId: Int, color: String, size: String, quantity: Int, price: Double, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "\(baseURL)/cart/add") else {
            completion(false, "Invalid URL")
            return
        }
        
        let body: [String: Any] = [
            "userId": userId,
            "productId": productId,
            "color": color,
            "size": size,
            "quantity": quantity,
            "price": price
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(false, "Network error: \(error!.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true, "Product added to cart successfully")
            } else {
                completion(false, "Failed to add product to cart")
            }
        }.resume()
    }
}
