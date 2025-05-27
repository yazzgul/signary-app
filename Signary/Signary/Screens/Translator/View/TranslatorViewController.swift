
import UIKit
import Combine

class TranslatorViewController: UIViewController {

    private var contentView: TranslatorView = .init()
    private let viewModel: TranslatorViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: TranslatorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        navigationItem.title = "Translator"

        contentView.delegate = self

        checkTranslateWordUIImage()

    }
    func checkTranslateWordUIImage() {
        viewModel.$translateWordUIImagePublished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                if let img = image {
                    self?.contentView.configureView(with: img)
                }
            }
            .store(in: &cancellables)
    }

}
extension TranslatorViewController: TranslatorViewDelegate {
    func searchButtonDidPressed(word: String) {
        viewModel.translateWordWithUrl(word: word)
    }

}
