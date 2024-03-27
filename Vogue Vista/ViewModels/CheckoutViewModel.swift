import Foundation

class CheckoutViewModel: ObservableObject {
    let baseURL = "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com"
    
    // Add an @Published property to store the total amount
    @Published var totalAmount: Double
    
    // Modify the initializer to accept the total amount
    init(totalAmount: Double) {
        self.totalAmount = totalAmount
    }

    func checkoutCart() {
        guard let userId = UserDefaults.standard.object(forKey: "userId") as? Int else {
            print("User ID not found")
            return
        }

        let url = URL(string: "\(baseURL)/checkout/\(userId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Checkout error: \(error.localizedDescription)")
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    print("No data received")
                }
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    print("Checkout successful: \(jsonResponse)")
                }
            } catch {
                DispatchQueue.main.async {
                    print("Failed to decode checkout response")
                }
            }
        }.resume()
    }
}
