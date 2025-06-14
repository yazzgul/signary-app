
import UIKit

protocol MainViewDelegate: AnyObject {
    func openAlphabetButtonDidPressed()
    func openTranslatorButtonDidPressed()
    func openCameraButtonDidPressed()
    func openGameButtonDidPressed()

}

class MainView: UIView {

    private lazy var alphabetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkPurple()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alphabet", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont

        let action = UIAction { [weak self] _ in
            self?.delegate?.openAlphabetButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.delicateBlue().cgColor

        return button
    }()

    private lazy var dictionaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkPurple()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Translator", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont

        let action = UIAction { [weak self] _ in
            self?.delegate?.openTranslatorButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.delicateBlue().cgColor

        return button
    }()

    private lazy var gameButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkPurple()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Game", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont

        let action = UIAction { [weak self] _ in
            self?.delegate?.openGameButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.delicateBlue().cgColor

        return button
    }()

    private lazy var cameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .darkPurple()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try with camera", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont

        let action = UIAction { [weak self] _ in
            self?.delegate?.openCameraButtonDidPressed()
        }
        button.addAction(action, for: .touchUpInside)

        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.delicateBlue().cgColor

        return button
    }()

//    private lazy var leftViewsStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [alphabetButton, dictionaryButton])
//        stackView.axis = .vertical
//        stackView.alignment = .fill
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 17
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//
//    private lazy var rightViewsStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [gameButton, cameraButton])
//        stackView.axis = .vertical
//        stackView.alignment = .fill
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 17
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()

    private lazy var viewsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [alphabetButton, dictionaryButton, gameButton, cameraButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var delegate: MainViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension MainView {
    private func configureView() {
        addSubview(viewsStackView)

        NSLayoutConstraint.activate ([

            viewsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            alphabetButton.widthAnchor.constraint(equalToConstant: 150),
            alphabetButton.heightAnchor.constraint(equalToConstant: 130),

            dictionaryButton.widthAnchor.constraint(equalToConstant: 150),
            dictionaryButton.heightAnchor.constraint(equalToConstant: 130),

            cameraButton.widthAnchor.constraint(equalToConstant: 150),
            cameraButton.heightAnchor.constraint(equalToConstant: 130),

            gameButton.widthAnchor.constraint(equalToConstant: 150),
            gameButton.heightAnchor.constraint(equalToConstant: 130),

        ])

    }
}
