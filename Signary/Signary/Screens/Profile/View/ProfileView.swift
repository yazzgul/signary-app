
import UIKit

class ProfileView: UIView {
    private lazy var yourEmailCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Your email:"
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkBlue()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkBlue()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var emailDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yourEmailCaptionLabel, emailLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    

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
        addSubview(emailDataStackView)

        NSLayoutConstraint.activate([

//            loginTextFieldsStackView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 20),
//            loginTextFieldsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

            emailDataStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailDataStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

            yourEmailCaptionLabel.widthAnchor.constraint(equalToConstant: 150),
            yourEmailCaptionLabel.heightAnchor.constraint(equalToConstant: 50),

            emailLabel.widthAnchor.constraint(equalToConstant: 150),
            emailLabel.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
}
