
import UIKit

class LearntWordsView: UIView {

    private lazy var wordsTableView: UITableView = {
        let table = UITableView()
        table.register(LearntWordsTableViewCell.self, forCellReuseIdentifier: LearntWordsTableViewCell.reuseIdentifier)
        table.backgroundColor = .lightBlue()
        table.contentInsetAdjustmentBehavior = .never
        table.rowHeight = 50
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var noDataCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "You didn`t learn any words yet"
        label.numberOfLines = 1
        label.font = .bodyFont
        label.textColor = .delicateBlue()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
extension LearntWordsView {
    private func configureView() {
        addSubview(wordsTableView)
        addSubview(noDataCaptionLabel)

        NSLayoutConstraint.activate ([

            noDataCaptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noDataCaptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            wordsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            wordsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            wordsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wordsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension LearntWordsView {
    func setupDataSource(_ dataSource: UITableViewDataSource) {
        self.wordsTableView.dataSource = dataSource
    }

    func setupDelegate(_ delegate: UITableViewDelegate) {
        self.wordsTableView.delegate = delegate
    }

    func reloadData() {
        wordsTableView.reloadData()
    }

}
extension LearntWordsView {
    func hideNoDataCaptionLabel(isHidden: Bool) {
        noDataCaptionLabel.isHidden = isHidden
    }
}
