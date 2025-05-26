
import UIKit

protocol GoToStartScreenSignOutViewDelegate: AnyObject {
    func signOutButtonDidPressed()
}
protocol DeleteProfileViewDelegate: AnyObject {
    func deleteProfileButtonDidPressed()
}


class ProfileView: UIView {
    private lazy var yourUsernameCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Your username:"
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkPurple()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkPurple()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var yourEmailCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Your email:"
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkPurple()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkPurple()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yourEmailCaptionLabel, emailLabel, yourUsernameCaptionLabel, usernameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var usernameDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yourUsernameCaptionLabel, usernameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var allDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailDataStackView, usernameDataStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .subtitleFont
        button.backgroundColor = .darkBlue()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            self?.signOutDelegate?.signOutButtonDidPressed()
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var deleteProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete Profile", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .subtitleFont
        button.backgroundColor = .darkBlue()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            self?.deleteProfileDelegate?.deleteProfileButtonDidPressed()
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [deleteProfileButton, signOutButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var signOutDelegate: GoToStartScreenSignOutViewDelegate?
    weak var deleteProfileDelegate: DeleteProfileViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ProfileView {
    private func configureView() {
//        addSubview(emailDataStackView)
//        addSubview(usernameDataStackView)
        addSubview(allDataStackView)
//        addSubview(signOutButton)
        addSubview(buttonsStackView)

        NSLayoutConstraint.activate([

//            loginTextFieldsStackView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 20),
//            loginTextFieldsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            allDataStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            allDataStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

//            emailDataStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            emailDataStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

//            usernameDataStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            usernameDataStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

            yourEmailCaptionLabel.widthAnchor.constraint(equalToConstant: 100),
            yourEmailCaptionLabel.heightAnchor.constraint(equalToConstant: 50),

            emailLabel.widthAnchor.constraint(equalToConstant: 200),
            emailLabel.heightAnchor.constraint(equalToConstant: 50),

            yourUsernameCaptionLabel.widthAnchor.constraint(equalToConstant: 150),
            yourUsernameCaptionLabel.heightAnchor.constraint(equalToConstant: 50),

            usernameLabel.widthAnchor.constraint(equalToConstant: 150),
            usernameLabel.heightAnchor.constraint(equalToConstant: 50),

            deleteProfileButton.widthAnchor.constraint(equalToConstant: 150),
            deleteProfileButton.heightAnchor.constraint(equalToConstant: 50),

            signOutButton.widthAnchor.constraint(equalToConstant: 150),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),

            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),



        ])
    }
    public func configureView(email: String, username: String) {
        emailLabel.text = email
        usernameLabel.text = username
    }

}
