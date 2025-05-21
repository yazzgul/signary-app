
import UIKit

class SignUpViewController: UIViewController {

    private var contentView: SignUpView = .init()
    private let viewModel: SignUpViewModel

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        navigationItem.hidesBackButton = true
        contentView.signInDelegate = self

    }

}
extension SignUpViewController: BackToSignInScreenViewDelegate {
    func backToSignInButtonDidPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
