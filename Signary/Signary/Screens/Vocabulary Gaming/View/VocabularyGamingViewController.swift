
import UIKit
import Combine

// игра вспомни слово
class VocabularyGamingViewController: UIViewController {

    private var contentView: VocabularyGamingView = .init()
    private let viewModel: VocabularyGamingViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: VocabularyGamingViewModel) {
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

        navigationItem.title = "Game"

        contentView.delegate = self
        contentView.setupDelegateForTextFields(viewControllerDelegate: self)

        loadLearntWordsList()

        checkTranslateWordList()



    }


}
extension VocabularyGamingViewController {
    func loadLearntWordsList() {
        viewModel.getLearntWordsLists()
    }

    func checkTranslateWordList() {
        viewModel.$currentUnlearntWord
            .receive(on: DispatchQueue.main)
            .sink { [weak self] word in
                if let word = word {
                    self?.contentView.configureView(with: word)
                    self?.contentView.hideWordDataCaptionLabel(isHidden: true)
                } else {
                    self?.contentView.hideWordDataCaptionLabel(isHidden: false)

                }
            }
            .store(in: &cancellables)
    }
}
extension VocabularyGamingViewController: VocabularyGamingViewDelegate {
    func submitButtonDidPressed(word: String) {
        viewModel.checkSubmitWord(word: word)
    }

}
extension VocabularyGamingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
