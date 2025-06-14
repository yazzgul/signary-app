
import UIKit

class AlphabetView: UIView {
    private lazy var alphabetImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(named: "sign-lang-alphabet")
        imageView.contentMode = .scaleToFill
//        imageView.contentMode = .scaleAspectFill

        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.darkPurple(alpha: 0.5).cgColor

        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
extension AlphabetView {
    private func configureView() {

        addSubview(alphabetImageView)

        NSLayoutConstraint.activate([

            alphabetImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            alphabetImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            alphabetImageView.heightAnchor.constraint(equalToConstant: 320),
            alphabetImageView.widthAnchor.constraint(equalToConstant: 370)

        ])
    }
}
