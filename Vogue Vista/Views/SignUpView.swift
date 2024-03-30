

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingLogin = false

    private let usersModel = UsersModel()
    
    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "person.crop.circle.badge.plus")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .padding(.bottom, 50)
                .foregroundColor(AppColor.appPrimary)

  
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                TextField("Name", text: $name)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)

            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 10)
            

            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.gray)
                SecureField("Password", text: $password)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 10)

            Button("Sign Up") {
                signUpButtonTapped()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColor.appPrimary)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 20)
            
            Spacer()

            HStack {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                
                Button("Log In") {
                    self.showingLogin = true
                }
                .foregroundColor(AppColor.appPrimary)
            }
            .padding(.bottom)
            .sheet(isPresented: $showingLogin) {
                        LoginView()
                    }
            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func signUpButtonTapped() {
        usersModel.registerUser(email: email, password: password, name: name) { success, error in
            DispatchQueue.main.async {
                if success {
                    self.alertTitle = "Success"
                    self.alertMessage = "You have successfully registered."
                    self.showingAlert = true
                } else if let error = error {
                    self.alertTitle = "Registration Error"
                    self.alertMessage = error.localizedDescription
                    self.showingAlert = true
                }
            }
        }
    }
}
