
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var navigateToHome = false
    @State private var showingSignup = false
    
    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipped()
                .padding(.bottom, 50)
                .foregroundColor(AppColor.appPrimary)
            


            
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                TextField("Email", text: $email)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            

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
            

            Button("Log In") {
                loginButtonTapped()
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
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button("Sign Up") {
                    self.showingSignup = true
                }
                .foregroundColor(AppColor.appPrimary)
            }
            .padding(.bottom)
            .sheet(isPresented: $showingSignup) {
                        SignUpView()
                    }
            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                if self.alertTitle == "Login Success" {
                    self.navigateToHome = true
                }
            })
        }
        .fullScreenCover(isPresented: $navigateToHome) {
            HomeView()
        }
    }
    
    private func loginButtonTapped() {
        guard !email.isEmpty, !password.isEmpty else {
            alertTitle = "Input Error"
            alertMessage = "Please enter your email and password."
            showingAlert = true
            return
        }
        let usersModel = UsersModel()
        usersModel.loginUser(email: email, password: password) { loginResponse, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertTitle = "Login Error"
                    self.alertMessage = "Failed to log in: \(error.localizedDescription)"
                    self.showingAlert = true
                } else if loginResponse != nil {

                    UserDefaults.standard.set(loginResponse?.userId, forKey: "userId")
                    UserDefaults.standard.set(loginResponse?.token, forKey: "userToken")
                    
                    self.alertTitle = "Login Success"
                    self.alertMessage = "You're now logged in!"
                    self.showingAlert = true

                } else {
                    self.alertTitle = "Login Error"
                    self.alertMessage = "An unknown error occurred."
                    self.showingAlert = true
                }
            }
        }
    }
}
