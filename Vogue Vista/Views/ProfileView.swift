import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileModel = ProfileModel()
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .padding()
        }
        Form {
            Section(header: Text("Profile Information").font(.title)) {
                HStack {
                    Image(systemName: "person.fill")
                    TextField("Name", text: Binding(get: { self.profileModel.profile?.name ?? "" }, set: { self.profileModel.profile?.name = $0 }))
                }
                
                HStack {
                    Image(systemName: "envelope.fill")
                    TextField("Email", text: Binding(get: { self.profileModel.profile?.email ?? "" }, set: { self.profileModel.profile?.email = $0 }))
                }
                
                HStack {
                    Image(systemName: "house.fill")
                    TextField("Address", text: Binding(get: { self.profileModel.profile?.address ?? "" }, set: { self.profileModel.profile?.address = $0 }))
                }
                Button("Update Profile") {
                    self.profileModel.updateProfileData()
                }
            }
            

            
            Button("Sign Out") {
                // Implement sign out logic here
            }
        }
    }
}

}
