
import UIKit

protocol SignUpGoToMainScreenSignUpViewDelegate: AnyObject {
    func signUpButtonDidPressed(username: String, email: String, password: String, passwordCheck: String)
}
protocol BackToSignInScreenSignUpViewDelegate: AnyObject {
    func backToSignInButtonDidPressed()
}

class SignUpView: UIView {

    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.numberOfLines = 1
        label.font = .titleFont
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Your Username (agent007, ...)",
            attributes: [
                .foregroundColor: UIColor.lightBlue(),
                .font: UIFont.bodyFont
            ]
        )
        textField.backgroundColor = .darkPurple()
        textField.textColor = .lightBlue()
//        textField.borderStyle = .roundedRect
        textField.font = .bodyFont

        textField.clipsToBounds = true
        textField.layer.cornerRadius = 25

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Email",
            attributes: [
                .foregroundColor: UIColor.lightBlue(),
                .font: UIFont.bodyFont
            ]
        )
        textField.backgroundColor = .darkPurple()
        textField.textColor = .lightBlue()
        textField.font = .bodyFont

        textField.clipsToBounds = true
        textField.layer.cornerRadius = 25

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Password",
            attributes: [
                .foregroundColor: UIColor.lightBlue(),
                .font: UIFont.bodyFont
            ]
        )
        textField.backgroundColor = .darkPurple()
        textField.textColor = .lightBlue()
        textField.font = .bodyFont

        textField.clipsToBounds = true
        textField.layer.cornerRadius = 25

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.isSecureTextEntry = true

        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Password Again",
            attributes: [
                .foregroundColor: UIColor.lightBlue(),
                .font: UIFont.bodyFont
            ]
        )
        textField.backgroundColor = .darkPurple()
        textField.textColor = .lightBlue()
        textField.font = .bodyFont

        textField.clipsToBounds = true
        textField.layer.cornerRadius = 25

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.isSecureTextEntry = true

        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var signUpToMainScreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont
        button.backgroundColor = .darkPurple()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            if let username = self?.usernameTextField.text,
               let email = self?.emailTextField.text,
               let password = self?.passwordTextField.text,
               let passwordCheck = self?.passwordCheckTextField.text {
                self?.signUpToMainScreenDelegate?.signUpButtonDidPressed(username: username, email: email, password: password, passwordCheck: passwordCheck)
            }
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var backToSignInScreenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Already have an account?", for: .normal)
        button.setTitleColor(.darkPurple(), for: .normal)
        button.titleLabel?.font = .bodyFont

        let action = UIAction { [weak self] _ in
            self?.signInDelegate?.backToSignInButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    private lazy var loginTextFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, emailTextField, passwordTextField, passwordCheckTextField])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var signUpToMainScreenDelegate: SignUpGoToMainScreenSignUpViewDelegate?
    weak var signInDelegate: BackToSignInScreenSignUpViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension SignUpView {
    private func configureView() {
        addSubview(captionLabel)
        addSubview(signUpToMainScreenButton)
        addSubview(loginTextFieldsStackView)
        addSubview(backToSignInScreenButton)

        NSLayoutConstraint.activate([

            loginTextFieldsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginTextFieldsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            captionLabel.bottomAnchor.constraint(equalTo: loginTextFieldsStackView.topAnchor, constant: -20),
            captionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            captionLabel.widthAnchor.constraint(equalToConstant: 150),
            captionLabel.heightAnchor.constraint(equalToConstant: 50),

            usernameTextField.widthAnchor.constraint(equalToConstant: 250),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),

            emailTextField.widthAnchor.constraint(equalToConstant: 250),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordCheckTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordCheckTextField.heightAnchor.constraint(equalToConstant: 50),

            backToSignInScreenButton.topAnchor.constraint(equalTo: loginTextFieldsStackView.bottomAnchor, constant: 10),
            backToSignInScreenButton.widthAnchor.constraint(equalToConstant: 200),
            backToSignInScreenButton.heightAnchor.constraint(equalToConstant: 25),
            backToSignInScreenButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            signUpToMainScreenButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpToMainScreenButton.widthAnchor.constraint(equalToConstant: 250),
            signUpToMainScreenButton.heightAnchor.constraint(equalToConstant: 50),
            signUpToMainScreenButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
    }
}
extension SignUpView {
    public func setupDelegateForTextFields(viewControllerDelegate: UITextFieldDelegate) {
        usernameTextField.delegate = viewControllerDelegate
        emailTextField.delegate = viewControllerDelegate
        passwordTextField.delegate = viewControllerDelegate
        passwordCheckTextField.delegate = viewControllerDelegate
    }
}
