import Foundation

struct User: Codable {
    var id: Int?
    var email: String
    var name: String?
}

struct LoginResponse: Codable {
    var token: String
}

class UsersModel {
    let baseUrlString = "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/users"
    
    func registerUser(email: String, password: String, name: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrlString)/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["email": email, "password": password, "name": name]
        guard let httpBody = try? JSONEncoder().encode(body) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            completion(true, nil)
        }.resume()
    }
    
    func loginUser(email: String, password: String, completion: @escaping (LoginResponse?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrlString)/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["email": email, "password": password]
        guard let httpBody = try? JSONEncoder().encode(body) else { return }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data, let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
                return
            }
            completion(loginResponse, nil)
        }.resume()
    }
}