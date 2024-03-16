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
                    isAuthenticated = true // This triggers the navigation to HomeView
                    // Handle credentials storage or further processing here
                    
                case .failure(let error):
                    print("Auth0 Login Failed: \(error)")
                    // Handle the error, perhaps by showing an alert
                    // This part is simplified for brevity
                }
            }
    }
}
