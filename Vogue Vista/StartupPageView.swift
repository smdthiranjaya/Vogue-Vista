import SwiftUI


struct StartupPageView: View {
    @State private var showingSignUp = false
    @State private var showingLogin = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image("logoPng")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("Welcome to Vogue Vista!")
                .font(.system(size: 24, weight: .medium))
            
            Text("Your style, your way.")
                .font(.system(size: 18, weight: .light))
            
            Divider()
            
            Button("Sign Up") {
                showingSignUp = true
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(AppColor.appPrimary)
            .cornerRadius(10)
            .padding()
            
            Button("Login") {
                showingLogin = true
            }
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(AppColor.appPrimary)
            .cornerRadius(10)
            .padding()
            
        }
        .sheet(isPresented: $showingSignUp) {
            SignUpView()
        }
        .sheet(isPresented: $showingLogin) {
            LoginView()
        }
    }
}

