
import UIKit

class LearntWordsDetailView: UIView {
    private lazy var wordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.delicateBlue().cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var itemsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wordImageView, wordLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
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
extension LearntWordsDetailView {
    private func configureView() {
        addSubview(itemsStackView)

        NSLayoutConstraint.activate ([

            itemsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

            wordImageView.widthAnchor.constraint(equalToConstant: 200),
            wordImageView.heightAnchor.constraint(equalToConstant: 200),

            wordLabel.widthAnchor.constraint(equalToConstant: 200),
            wordLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    public func configureView(with word: Word) {
        wordImageView.image = word.signImages
        wordLabel.text = word.name
    }
}

