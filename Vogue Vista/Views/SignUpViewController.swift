import SwiftUI

class SignUpViewController: UIViewController {
    private let usersModel = UsersModel()
    
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
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, nameTextField, signUpButton])
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
    
    @objc private func signUpButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(with: "Input Error", message: "Please enter your email.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(with: "Input Error", message: "Please enter your password.")
            return
        }
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(with: "Input Error", message: "Please enter your name.")
            return
        }
        
        usersModel.registerUser(email: email, password: password, name: name) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.showAlert(with: "Success", message: "You have successfully registered.")
                    
                } else if let error = error {
                    self?.showAlert(with: "Registration Error", message: error.localizedDescription)
                }
            }
        }
    }

    private func showAlert(with title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let loginVC = LoginViewController()
            if let navigator = self.navigationController {
                navigator.pushViewController(loginVC, animated: true)
            } else {
                self.present(loginVC, animated: true, completion: nil)
            }
            completion?()
        })
        present(alert, animated: true)
    }


}
