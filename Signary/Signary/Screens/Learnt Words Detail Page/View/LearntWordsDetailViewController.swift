
import UIKit

class LearntWordsDetailViewController: UIViewController {

    private var contentView: LearntWordsDetailView = .init()
    private let viewModel: LearntWordsDetailViewModel

    init(viewModel: LearntWordsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        navigationItem.title = "Learnt Words"

        configureContentWiewWithWord()

    }

}
extension LearntWordsDetailViewController {
    func configureContentWiewWithWord() {
        guard let word = viewModel.getSelectedWord() else { return }

        contentView.configureView(with: word)
    }
}
