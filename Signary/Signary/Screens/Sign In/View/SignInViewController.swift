
import UIKit

class SignInViewController: UIViewController {

    private var contentView: SignInView = .init()
    private let viewModel: SignInViewModel

    init(viewModel: SignInViewModel) {
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
        contentView.signUpDelegate = self

    }

}
extension SignInViewController: GoToSignUpScreenViewDelegate {
    func goToSignUpScreenButtonDidPressed() {
        let vm = SignUpViewModel()
        let vc = SignUpViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
