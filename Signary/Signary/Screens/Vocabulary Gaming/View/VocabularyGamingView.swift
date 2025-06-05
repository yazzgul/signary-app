
import UIKit

protocol VocabularyGamingViewDelegate: AnyObject {
    func submitButtonDidPressed(word: String)
}

class VocabularyGamingView: UIView {

    private lazy var translateWordImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "type-any-word")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.delicateBlue().cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var noWordCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "No words for learning..."
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .delicateBlue()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var guessTheWordLabel: UILabel = {
        let label = UILabel()
        label.text = "Guess the word:"
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var wordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type the word..."
        textField.backgroundColor = .delicateBlue()
        textField.textColor = .lightBlue()
        textField.borderStyle = .roundedRect
        textField.font = .bodyFont
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .subtitleFont
        button.backgroundColor = .darkBlue()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            if let word  = self?.wordTextField.text {
                self?.delegate?.submitButtonDidPressed(word: word)
            }
        }

        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [translateWordImageView, guessTheWordLabel, wordTextField, submitButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var delegate: VocabularyGamingViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension VocabularyGamingView {
    private func configureView() {
        addSubview(itemsStackView)
        addSubview(noWordCaptionLabel)

        NSLayoutConstraint.activate ([

            noWordCaptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noWordCaptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            itemsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            translateWordImageView.widthAnchor.constraint(equalToConstant: 200),
            translateWordImageView.heightAnchor.constraint(equalToConstant: 200),

            guessTheWordLabel.widthAnchor.constraint(equalToConstant: 250),
            guessTheWordLabel.heightAnchor.constraint(equalToConstant: 50),

            wordTextField.widthAnchor.constraint(equalToConstant: 250),
            wordTextField.heightAnchor.constraint(equalToConstant: 50),

            submitButton.widthAnchor.constraint(equalToConstant: 150),
            submitButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    public func configureView(with word: Word) {
        translateWordImageView.image = word.signImages
    }
    func hideWordDataCaptionLabel(isHidden: Bool) {
        itemsStackView.isHidden = !isHidden
//        translateWordImageView.isHidden = !isHidden
        noWordCaptionLabel.isHidden = isHidden
    }
}
extension VocabularyGamingView {
    public func setupDelegateForTextFields(viewControllerDelegate: UITextFieldDelegate) {
        wordTextField.delegate = viewControllerDelegate
    }
}
