import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileModel = ProfileModel()

    var body: some View {
        // Attempt to retrieve and convert the userId to Int
        guard let userIdString = UserDefaults.standard.string(forKey: "userId"),
              let userId = Int(userIdString) else {
            // Consider what should happen if userId is not available or not convertible to Int
            // For simplicity, this example returns an empty view.
            // You might want to navigate the user to a different view or show an error.
            return Text("User ID not found or invalid").toAnyView()
        }
        
        return Form {
            Section(header: Text("Profile Information")) {
                TextField("Name", text: Binding(
                    get: { self.profileModel.profile?.name ?? "" },
                    set: { self.profileModel.profile?.name = $0 }
                ))
                TextField("Email", text: Binding(
                    get: { self.profileModel.profile?.email ?? "" },
                    set: { self.profileModel.profile?.email = $0 }
                ))
                TextField("Address", text: Binding(
                    get: { self.profileModel.profile?.address ?? "" },
                    set: { self.profileModel.profile?.address = $0 }
                ))
                Button("Update Profile") {
                    // Call function to update profile
                }
            }
        }
        .onAppear {
            self.profileModel.fetchProfileData(userId: userId)
        }
        .toAnyView() // Extension to convert View to AnyView for conditional view logic
    }
}

// Extension to help with conditional view logic by converting any View into AnyView
extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
