
import UIKit

protocol ResetPasswordButtonResetPasswordViewDelegate: AnyObject {
    func resetPasswordButtonDidPressed(email: String)
}
class ResetPasswordView: UIView {
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Reset"
        label.numberOfLines = 2
        label.font = .titleFont
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Your Email"
        textField.backgroundColor = .darkBlue()
        textField.textColor = .lightBlue()
        textField.borderStyle = .roundedRect
        textField.font = .bodyFont
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var resetPasswordButton: UIButton = {
//        let button = UIButton()
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .subtitleFont
        button.backgroundColor = .darkBlue()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            if let email = self?.emailTextField.text {
                self?.resetPasswordDelegate?.resetPasswordButtonDidPressed(email: email)
            }
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var resetPasswordDelegate: ResetPasswordButtonResetPasswordViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension ResetPasswordView {
    private func configureView() {
        addSubview(emailTextField)
        addSubview(captionLabel)
        addSubview(resetPasswordButton)

        NSLayoutConstraint.activate([

            emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 250),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            captionLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -20),
            captionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            captionLabel.widthAnchor.constraint(equalToConstant: 150),
            captionLabel.heightAnchor.constraint(equalToConstant: 50),

            resetPasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resetPasswordButton.widthAnchor.constraint(equalToConstant: 150),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 50),
            resetPasswordButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
    }
}


