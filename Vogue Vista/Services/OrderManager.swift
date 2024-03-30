import Foundation

class OrderManager {
    let baseURL = URL(string: AppConfiguration.serverURL)!
    
    func sendOrderToServer(_ orderDetails: Order) {
        guard let url = URL(string: "\(baseURL)/order/create") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(orderDetails)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error sending order: \(error)")
                    return
                }
                guard let data = data else {
                    print("No data received")
                    return
                }
            }.resume()
        } catch {
            print("Error encoding order details: \(error)")
        }
    }
    
}
