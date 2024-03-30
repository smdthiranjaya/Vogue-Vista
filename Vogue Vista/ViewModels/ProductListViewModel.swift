import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var specialOffers: [Product] = []
    
    func loadSpecialOffers() {
        guard let url = URL(string: "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/special-offers") else {
            print("Invalid URL for special offers")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error with the response, unexpected status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        self.specialOffers = decodedResponse
                        print("Special offers loaded: \(self.specialOffers.count)")
                    }
                } catch let jsonError {
                    print("Failed to decode JSON for special offers: \(jsonError.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    func loadProducts(searchText: String = "") {
        var components = URLComponents(string: "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/products")
        
        var queryItems = [URLQueryItem]()
        if !searchText.isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: searchText))
        }
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                
                print("Error fetching products: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                
                print("Error with the response, unexpected status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }
            
            if let data = data {
                do {
                    
                    let decodedResponse = try JSONDecoder().decode([Product].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.products = decodedResponse
                    }
                } catch let jsonError {
                    
                    print("Failed to decode JSON: \(jsonError.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}
