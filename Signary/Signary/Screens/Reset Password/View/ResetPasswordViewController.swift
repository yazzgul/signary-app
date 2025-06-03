
import UIKit
import Combine

class ResetPasswordViewController: UIViewController {

    private var contentView: ResetPasswordView = .init()
    private let viewModel: ResetPasswordViewModel

    private var cancellable: AnyCancellable?

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

        contentView.resetPasswordDelegate = self

        contentView.setupDelegateForTextFields(viewControllerDelegate: self)

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
