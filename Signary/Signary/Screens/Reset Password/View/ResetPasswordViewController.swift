
import UIKit
import Combine

class ResetPasswordViewController: UIViewController {

    private var contentView: ResetPasswordView = .init()
    private let viewModel: ResetPasswordViewModel

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: ResetPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView

        NavigationBarAppearanceConfiguration.applyTitleView(to: navigationItem)

        contentView.resetPasswordDelegate = self

        contentView.setupDelegateForTextFields(viewControllerDelegate: self)

        showInvalidEmailAlert()
        showSomethingWentWrongAlert()
        showCheckEmailAlert()

    }

}
extension ResetPasswordViewController: ResetPasswordButtonResetPasswordViewDelegate {
    func resetPasswordButtonDidPressed(email: String) {
        viewModel.resetPasswordWithFirebaseEmail(email: email)
    }
}
extension ResetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension ResetPasswordViewController {
    func showSomethingWentWrongAlert() {
        viewModel.$showSomethingWentWrongAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showSomethingWentWrongAlert(on: self!)
                }
            }
            .store(in: &cancellables)
    }
    func showInvalidEmailAlert() {
        viewModel.$showInvalidEmailAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showInvalidEmailAlert(on: self!)
                }
            }
            .store(in: &cancellables)
    }
    func showCheckEmailAlert() {
        viewModel.$showCheckEmailAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showSendLetterToEmailPasswordResetAlert(on: self!)
                }
            }
            .store(in: &cancellables)
    }
}
