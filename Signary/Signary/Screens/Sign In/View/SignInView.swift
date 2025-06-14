
import UIKit

protocol GoToSignUpScreenSignInViewDelegate: AnyObject {
    func goToSignUpScreenButtonDidPressed()
}
protocol GoToResetPasswordScreenSignInViewDelegate: AnyObject {
    func goToResetPasswordScreenButtonDidPressed()
}
protocol SignInGoToMainScreenSignInViewDelegate: AnyObject {
    func signInButtonDidPressed(email: String, password: String)
}

class SignInView: UIView {
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.numberOfLines = 1
        label.font = .titleFont
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var haveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don`t have an account?"
        label.numberOfLines = 1
        label.font = .bodyFont
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = .bodyFont
        textField.backgroundColor = .darkPurple()
        textField.textColor = .lightBlue()

        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Email",
            attributes: [
                .foregroundColor: UIColor.lightBlue(),
                .font: UIFont.bodyFont
            ]
        )

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

        textField.borderStyle = .roundedRect
        textField.font = .bodyFont

        textField.clipsToBounds = true
        textField.layer.cornerRadius = 25

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var goToMainScreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont
        button.backgroundColor = .darkPurple()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            if let email = self?.emailTextField.text, let password = self?.passwordTextField.text {
                self?.mainScreenDelegate?.signInButtonDidPressed(email: email, password: password)
            }
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var goToSignUpScreenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Don`t have an account? Sign Up", for: .normal)
        button.setTitleColor(.darkPurple(), for: .normal)
        button.titleLabel?.font = .bodyFont

        let action = UIAction { [weak self] _ in
            self?.signUpDelegate?.goToSignUpScreenButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()
    private lazy var goToResetPasswordScreenButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Forgot password? Reset it", for: .normal)
        button.setTitleColor(.darkPurple(), for: .normal)
        button.titleLabel?.font = .bodyFont

        let action = UIAction { [weak self] _ in
            self?.resetPasswordDelegate?.goToResetPasswordScreenButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()
    private lazy var loginTextFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var signUpDelegate: GoToSignUpScreenSignInViewDelegate?
    weak var mainScreenDelegate: SignInGoToMainScreenSignInViewDelegate?
    weak var resetPasswordDelegate: GoToResetPasswordScreenSignInViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension SignInView {
    private func configureView() {
        addSubview(captionLabel)
        addSubview(goToMainScreenButton)
        addSubview(loginTextFieldsStackView)
        addSubview(goToSignUpScreenButton)
        addSubview(goToResetPasswordScreenButton)


        NSLayoutConstraint.activate([

//            loginTextFieldsStackView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 20),
//            loginTextFieldsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            loginTextFieldsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginTextFieldsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            captionLabel.bottomAnchor.constraint(equalTo: loginTextFieldsStackView.topAnchor, constant: -20),
            captionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            captionLabel.widthAnchor.constraint(equalToConstant: 150),
            captionLabel.heightAnchor.constraint(equalToConstant: 50),

            emailTextField.widthAnchor.constraint(equalToConstant: 250),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            goToSignUpScreenButton.topAnchor.constraint(equalTo: loginTextFieldsStackView.bottomAnchor, constant: 10),
            goToSignUpScreenButton.widthAnchor.constraint(equalToConstant: 200),
            goToSignUpScreenButton.heightAnchor.constraint(equalToConstant: 25),
            goToSignUpScreenButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            goToResetPasswordScreenButton.bottomAnchor.constraint(equalTo: goToMainScreenButton.topAnchor, constant: -10),
            goToResetPasswordScreenButton.widthAnchor.constraint(equalToConstant: 200),
            goToResetPasswordScreenButton.heightAnchor.constraint(equalToConstant: 25),
            goToResetPasswordScreenButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            goToMainScreenButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            goToMainScreenButton.widthAnchor.constraint(equalToConstant: 250),
            goToMainScreenButton.heightAnchor.constraint(equalToConstant: 50),
            goToMainScreenButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
    }
}
extension SignInView {
    public func setupDelegateForTextFields(viewControllerDelegate: UITextFieldDelegate) {
        emailTextField.delegate = viewControllerDelegate
        passwordTextField.delegate = viewControllerDelegate
    }
}

