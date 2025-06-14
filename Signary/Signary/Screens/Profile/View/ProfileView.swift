
import UIKit

protocol GoToStartScreenSignOutProfileViewDelegate: AnyObject {
    func signOutButtonDidPressed()
}
protocol DeleteProfileViewDelegate: AnyObject {
    func deleteProfileButtonDidPressed()
}
protocol OpenLearntWordsListProfileViewDelegate: AnyObject {
    func learntWordsButtonDidPressed()
}


class ProfileView: UIView {
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "five-no-avatar")

        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 125

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello!"
        label.numberOfLines = 1
        label.font = .titleFont

        label.backgroundColor = .darkPurple()
        label.textColor = .lightBlue()

        label.clipsToBounds = true
        label.layer.cornerRadius = 25

        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var learntWordsListButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My learnt words", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont
        button.backgroundColor = .darkPurple()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            self?.learntWordsDelegate?.learntWordsButtonDidPressed()
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont
        button.backgroundColor = .darkPurple()
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
        button.titleLabel?.font = .mainButtonFont
        button.backgroundColor = .darkPurple()
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
        let stackView = UIStackView(arrangedSubviews: [learntWordsListButton, deleteProfileButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, profileImageView, buttonsStackView])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var signOutDelegate: GoToStartScreenSignOutProfileViewDelegate?
    weak var deleteProfileDelegate: DeleteProfileViewDelegate?
    weak var learntWordsDelegate: OpenLearntWordsListProfileViewDelegate?



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
        addSubview(profileInfoStackView)
        addSubview(signOutButton)

        NSLayoutConstraint.activate([

            profileInfoStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileInfoStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

            usernameLabel.widthAnchor.constraint(equalToConstant: 300),
            usernameLabel.heightAnchor.constraint(equalToConstant: 50),

            profileImageView.widthAnchor.constraint(equalToConstant: 250),
            profileImageView.heightAnchor.constraint(equalToConstant: 250),

            learntWordsListButton.widthAnchor.constraint(equalToConstant: 250),
            learntWordsListButton.heightAnchor.constraint(equalToConstant: 50),

            deleteProfileButton.widthAnchor.constraint(equalToConstant: 250),
            deleteProfileButton.heightAnchor.constraint(equalToConstant: 50),

            signOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 250),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),
            signOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),

        ])
    }
    public func configureView(username: String) {
        usernameLabel.text = "Hello, \(username)!"
    }

}
