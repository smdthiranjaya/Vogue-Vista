import SwiftUI

class LoginViewController: UIViewController {
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }



    @objc private func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(with: "Input Error", message: "Please enter your email.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(with: "Input Error", message: "Please enter your password.")
            return
        }
        
        let usersModel = UsersModel()
        usersModel.loginUser(email: email, password: password) { [weak self] loginResponse, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error, perhaps showing an alert to the user
                    self?.showAlert(with: "Login Error", message: "Failed to log in: \(error.localizedDescription)")
                } else if let loginResponse = loginResponse {
                    // Login was successful
                    UserDefaults.standard.set(loginResponse.token, forKey: "userToken")
                    self?.showAlert(with: "Login Success", message: "You're now logged in!")
                    // self?.switchToHomeView()
                } else {
                    // Handle unexpected error
                    self?.showAlert(with: "Login Error", message: "An unknown error occurred.")
                }
            }
        }
    }
    
    private func showAlert(with title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.switchToHomeView()
            completion?() // Call the completion handler if it exists
        })
        present(alert, animated: true)
    }

    func switchToHomeView() {
        DispatchQueue.main.async {
            let homeViewController = UIHostingController(rootView: HomeView())
            // Use the view.window to change the rootViewController
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
