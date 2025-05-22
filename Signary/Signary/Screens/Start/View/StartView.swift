
import UIKit

protocol NextScreenStartViewDelegate: AnyObject {
    func nextScreenButtonDidPressed()
}

class StartView: UIView {
    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Signary"
        label.numberOfLines = .zero
        label.font = .titleFont
//        label.font = .systemFont(ofSize: 50, weight: .heavy, width: .condensed)
        label.textColor = .darkBlue()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore the sign language world!"
        label.numberOfLines = .zero
        label.font = .subtitleFont
//        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .darkPurple()
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nextButton: UIButton = {
//        let button = UIButton()
        let button = UIButton(type: .system)

        button.setTitle("Start", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .subtitleFont
        button.backgroundColor = .darkBlue()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            self?.delegate?.nextScreenButtonDidPressed()

        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var appNameCaptionLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appNameLabel, captionLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    weak var delegate: NextScreenStartViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension StartView {
    private func configureView() {
        addSubview(appNameLabel)
        addSubview(captionLabel)
        addSubview(nextButton)
        addSubview(appNameCaptionLabelsStackView)

        NSLayoutConstraint.activate([
            appNameCaptionLabelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            appNameCaptionLabelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),

            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 150),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
    }

}
