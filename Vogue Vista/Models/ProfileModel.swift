import Foundation

struct Profile: Codable, Equatable {
    var id: String
    var name: String
    var email: String
    var address: String?
    // Add other fields as necessary
}


class ProfileModel: ObservableObject {
    @Published var profile: Profile?
    
    func fetchProfileData(userId: Int) {
        guard let url = URL(string: "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/users/\(userId)") else { return }
        
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

}
