import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileModel = ProfileModel()
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var navigateToLogin = false
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .bold()
                .padding(.top, 15)

            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .padding()
                .foregroundColor(AppColor.appPrimary)
        }
        .onAppear {
            guard let userId = UserDefaults.standard.object(forKey: "userId") as? Int else {
                print("User ID not found")
                return
            }
            profileModel.fetchProfileData(userId: userId)
        }
        Form {
            Section(header: Text("Profile Information").font(.headline)) {
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(AppColor.appPrimary)
                    TextField("Name", text: Binding(get: { self.profileModel.profile?.name ?? "" }, set: { self.profileModel.profile?.name = $0 }))
                }
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(AppColor.appPrimary)
                    TextField("Email", text: Binding(get: { self.profileModel.profile?.email ?? "" }, set: { self.profileModel.profile?.email = $0 }))
                }
                
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(AppColor.appPrimary)
                    TextField("Address", text: Binding(get: { self.profileModel.profile?.address ?? "" }, set: { self.profileModel.profile?.address = $0 }))
                }
            }
            
            Button("Update Profile") {
                self.profileModel.updateProfileData()
            }.buttonStyle(FilledRoundedButtonStyle())
            
            Button("Sign Out") {
                showingAlert = true
            }.buttonStyle(FilledRoundedButtonStyle())
        }.alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Log Out"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Yes")) {
                    UserDefaults.standard.removeObject(forKey: "userToken")
                    UserDefaults.standard.removeObject(forKey: "userId")
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


struct FilledRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(AppColor.appPrimary)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
