
import UIKit

protocol TranslatorViewDelegate: AnyObject {
    func searchButtonDidPressed(word: String)
}

class TranslatorView: UIView {
    private var imageAspectRatioConstraint: NSLayoutConstraint?

    private lazy var translateWordImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "type-any-word")
        imageView.contentMode = .scaleAspectFill


        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.darkPurple(alpha: 0.5).cgColor

        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var translatorTextField: UITextField = {
        let textField = UITextField()
        textField.font = .bodyFont
        textField.backgroundColor = .darkPurple(alpha: 0.9)
        textField.textColor = .lightBlue()

        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Any Word",
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

    private lazy var searchGlassButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "magnifyingglass")
        button.setImage(image, for: .normal)
        button.tintColor = .darkPurple()
        button.clipsToBounds = true
//        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            if let text = self?.translatorTextField.text {
                self?.delegate?.searchButtonDidPressed(word: text)
            }
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "The remote server responds with a delay. \nThe waiting time for translating may vary."
        label.textColor = .delicateBlue()
        label.font = .bodyFont
        label.textAlignment = .center
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var searchItemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [translatorTextField, searchGlassButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var delegate: TranslatorViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension TranslatorView {
    private func configureView() {
        addSubview(searchItemsStackView)
        addSubview(translateWordImageView)
        addSubview(warningLabel)

        NSLayoutConstraint.activate([

            translateWordImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            translateWordImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            translateWordImageView.widthAnchor.constraint(equalToConstant: 370),

            searchItemsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchItemsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),

            warningLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            warningLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            warningLabel.widthAnchor.constraint(equalToConstant: 300),
            warningLabel.heightAnchor.constraint(equalToConstant: 70),

            translatorTextField.widthAnchor.constraint(equalToConstant: 300),
            translatorTextField.heightAnchor.constraint(equalToConstant: 50),

            searchGlassButton.widthAnchor.constraint(equalToConstant: 50),
            searchGlassButton.heightAnchor.constraint(equalToConstant: 50)

            ])
    }

    public func configureView(with image: UIImage) {
        translateWordImageView.image = image

        if let existingConstraint = imageAspectRatioConstraint {
            translateWordImageView.removeConstraint(existingConstraint)
        }

        let aspectRatio = image.size.height / image.size.width

        let newConstraint = translateWordImageView.heightAnchor.constraint(equalTo: translateWordImageView.widthAnchor, multiplier: aspectRatio)
        newConstraint.isActive = true
        imageAspectRatioConstraint = newConstraint
    }

}
extension TranslatorView {
    public func setupDelegateForTextFields(viewControllerDelegate: UITextFieldDelegate) {
        translatorTextField.delegate = viewControllerDelegate
    }
}
