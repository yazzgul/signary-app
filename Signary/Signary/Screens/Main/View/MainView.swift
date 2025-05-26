
import UIKit

class MainView: UIView {

    private lazy var alphabetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkPurple()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alphabet", for: .normal)
        button.layer.cornerRadius = 75
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .bodyFont

        let action = UIAction { [weak self] _ in
//            self?.signUpDelegate?.goToSignUpScreenButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()
    private lazy var dictionaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkPurple()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Translator", for: .normal)
        button.layer.cornerRadius = 75
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .bodyFont

        let action = UIAction { [weak self] _ in
//            self?.signUpDelegate?.goToSignUpScreenButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()
    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkPurple()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try with camera", for: .normal)
        button.layer.cornerRadius = 75
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .bodyFont

        let action = UIAction { [weak self] _ in
//            self?.signUpDelegate?.goToSignUpScreenButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var viewsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [alphabetButton, dictionaryButton, cameraButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 17
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()


}
extension MainView {
    private func configureView() {
        addSubview(viewsStackView)

        NSLayoutConstraint.activate ([

            viewsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            alphabetButton.widthAnchor.constraint(equalToConstant: 150),
            alphabetButton.heightAnchor.constraint(equalToConstant: 150),

            dictionaryButton.widthAnchor.constraint(equalToConstant: 150),
            dictionaryButton.heightAnchor.constraint(equalToConstant: 150),

            cameraButton.widthAnchor.constraint(equalToConstant: 150),
            cameraButton.heightAnchor.constraint(equalToConstant: 150),

        ])

    }
}
