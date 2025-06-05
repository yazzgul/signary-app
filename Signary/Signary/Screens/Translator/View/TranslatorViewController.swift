
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

        contentView.setupDelegateForTextFields(viewControllerDelegate: self)

        checkTranslateWordUIImage()

        showInvalidWordAlert()
        showSomethingWentWrongAlert()

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
extension TranslatorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension TranslatorViewController {
    func showSomethingWentWrongAlert() {
        viewModel.$showSomethingWentWrongAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showSomethingWentWrongAlert(on: self!)
                } else {
                    print("Что-то пошло не так! Не удалось показать Alert showSomethingWentWrongAlert.")
                }
                print(bool)
            }
            .store(in: &cancellables)
    }
    func showInvalidWordAlert() {
        viewModel.$showInvalidWordAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showInvalidTranslatedWordAlert(on: self!)
                } else {
                    print("Что-то пошло не так! Не удалось показать Alert.")
                }
                print(bool)
            }
            .store(in: &cancellables)
    }
}
