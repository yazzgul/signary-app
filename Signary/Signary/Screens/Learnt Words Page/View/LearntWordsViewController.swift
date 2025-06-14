
import UIKit
import Combine

class LearntWordsViewController: UIViewController {

    private var contentView: LearntWordsView = .init()
    private let viewModel: LearntWordsViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: LearntWordsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        loadLearntWordsList()

        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        NavigationBarAppearanceConfiguration.applyTitleView(to: navigationItem)

        contentView.setupDataSource(self)
        contentView.setupDelegate(self)

        loadLearntWordsList()
        checkLearntWordsListEmpty()

//        contentView.delegate = self

    }

}
extension LearntWordsViewController {
    func loadLearntWordsList() {
        viewModel.getLearntWordsList()
    }
    func checkLearntWordsListEmpty() {
        viewModel.$userLearntWords
            .receive(on: DispatchQueue.main)
            .sink { [weak self] array in
                if array.isEmpty {
                    self?.contentView.hideNoDataCaptionLabel(isHidden: false)
                } else {
                    self?.contentView.hideNoDataCaptionLabel(isHidden: true)
                }
                self?.contentView.reloadData()
            }
            .store(in: &cancellables)
    }
}
extension LearntWordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.configureCell(tableView, cellForRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.saveCurrentLearntWordTableSelected(didSelectRowAt: indexPath)

        let vm = LearntWordsDetailViewModel()
        let vc = LearntWordsDetailViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        viewModel.deleteByLeftSwipe(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
    }
}
