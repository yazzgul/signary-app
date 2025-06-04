
import UIKit

class LearntWordsTableViewCell: UITableViewCell {

    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .subtitleFont
        label.textColor = .darkPurple()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func prepareForReuse() {
        super.prepareForReuse()

        wordLabel.text = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = UIColor.lightBlue()
        configureView()
    }

}
extension LearntWordsTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension LearntWordsTableViewCell {
    private func configureView() {

        contentView.addSubview(wordLabel)

        NSLayoutConstraint.activate ([

            wordLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            wordLabel.widthAnchor.constraint(equalToConstant: 150),
            wordLabel.heightAnchor.constraint(equalToConstant: 50),

            wordLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])

    }

    func configureCell(with word: String) {
        wordLabel.text = word
    }
}

