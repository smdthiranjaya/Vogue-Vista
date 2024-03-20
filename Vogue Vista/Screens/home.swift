import SwiftUI

struct HomeView: View {
    @State private var showingAlert = false
    @State private var navigateToLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background Layer
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Text("Welcome to the Home Screen!")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding()
                    Spacer()
                }
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
            .navigationBarItems(
                leading: HStack {
                    Button(action: {
                        print("Profile icon tapped")
                    }) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                    }
                },
                trailing: HStack {
                    Button("Log Out") {
                        showingAlert = true
                    }
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Log Out"),
                    message: Text("Are you sure you want to log out?"),
                    primaryButton: .destructive(Text("Yes")) {
                        UserDefaults.standard.removeObject(forKey: "userToken")
                        navigateToLogin = true
                        
                    },
                    secondaryButton: .cancel()
                )
            }
            .fullScreenCover(isPresented: $navigateToLogin) {
                StartupPageViewRepresentable()
            }
        }
    }
    
}

