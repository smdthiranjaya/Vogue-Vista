import SwiftUI
import Auth0

struct LoginView: View {
    @State private var isAuthenticated = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Login") {
                    loginWithAuth0()
                }
            }
            .navigationDestination(isPresented: $isAuthenticated) {
                HomeView()
            }
        }
    }
    
    func loginWithAuth0() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    print("Auth0 Login Successful: \(credentials)")
                    fetchUserProfile(accessToken: credentials.accessToken)
                    
                case .failure(let error):
                    print("Auth0 Login Failed: \(error)")
                }
            }
    }
    
    func fetchUserProfile(accessToken: String) {
        Auth0
            .authentication()
            .userInfo(withAccessToken: accessToken)
            .start { result in
                switch result {
                case .success(let profile):
                    print("Profile: \(profile)")
                    sendLoginDetailsToServer(profile: profile, accessToken: accessToken)
                    isAuthenticated = true
                case .failure(let error):
                    print("Failed to fetch profile: \(error)")
                }
            }
    }
    
    func sendLoginDetailsToServer(profile: UserInfo, accessToken: String) {
        guard let url = URL(string: "https://ancient-taiga-27787-c7cd95aba2be.herokuapp.com/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "email": profile.email ?? "",
            "name": profile.name ?? "",
            "pictureURL": profile.picture?.absoluteString ?? "",
            "auth0Id": profile.sub // Make sure this line correctly extracts the Auth0 user ID
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error contacting your server application: \(error)")
                return
            }
            // Handle the response from your server application
        }
        task.resume()
    }

}
