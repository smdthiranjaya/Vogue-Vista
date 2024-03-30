
import Foundation

struct Profile: Codable, Equatable {
    var id: String
    var name: String
    var email: String
    var address: String?
}

class ProfileModel: ObservableObject {
    @Published var profile: Profile?
    let baseURL = URL(string: AppConfiguration.serverURL)!
    
    func fetchProfileData(userId: Int) {
        guard let url = URL(string: "\(baseURL)/users/\(userId)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(Profile.self, from: data)
                    DispatchQueue.main.async {
                        self.profile = decodedData
                    }
                    print("Fetched Profile: \(decodedData)")
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            } else if let error = error {
                print("Failed to fetch data: \(error)")
            }
        }.resume()
    }
    
    func updateProfileData() {
        guard let profile = profile,
              let url = URL(string: "\(baseURL)/users/\(profile.id)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let jsonData = try JSONEncoder().encode(profile)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Failed to update profile: \(error)")
                } else {
                    print("Profile successfully updated.")
                }
            }.resume()
        } catch {
            print("Failed to encode profile data: \(error)")
        }
    }
}
