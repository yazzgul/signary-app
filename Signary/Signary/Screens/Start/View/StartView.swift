
import UIKit

protocol NextScreenStartViewDelegate: AnyObject {
    func nextScreenButtonDidPressed()
}

class StartView: UIView {
    
    private lazy var icontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.raised")
        imageView.tintColor = UIColor.darkPurple()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

//
//        imageView.layer.borderWidth = 5
//        imageView.layer.borderColor = UIColor.delicateBlue().cgColor
//        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Signary"
        label.numberOfLines = .zero
        label.font = .titleFont
//        label.font = .systemFont(ofSize: 50, weight: .heavy, width: .condensed)
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore the sign language world!"
        label.numberOfLines = .zero
        label.font = .subtitleSmallFont
        label.textColor = .darkBlue()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var nextButton: UIButton = {
//        let button = UIButton()
        let button = UIButton(type: .system)

        button.setTitle("Start", for: .normal)
        button.setTitleColor(.lightBlue(), for: .normal)
        button.titleLabel?.font = .mainButtonFont
        button.backgroundColor = .darkPurple()
        button.clipsToBounds = true
        button.layer.cornerRadius = 25

        let action = UIAction { [weak self] _ in
            self?.delegate?.nextScreenButtonDidPressed()

        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var iconAppNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [icontImageView, appNameLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var appNameCaptionLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconAppNameStackView, captionLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
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
        addSubview(nextButton)
        addSubview(appNameCaptionLabelsStackView)

        NSLayoutConstraint.activate([

            appNameLabel.widthAnchor.constraint(equalToConstant: 150),
            appNameLabel.heightAnchor.constraint(equalToConstant: 80),

            icontImageView.widthAnchor.constraint(equalToConstant: 60),
            icontImageView.heightAnchor.constraint(equalToConstant: 60),

            captionLabel.widthAnchor.constraint(equalToConstant: 250),
            captionLabel.heightAnchor.constraint(equalToConstant: 30),

            appNameCaptionLabelsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            appNameCaptionLabelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 250),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)

        ])
    }

}
