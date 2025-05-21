
import UIKit

class StartViewController: UIViewController {

    private var contentView: StartView = .init()
    private let viewModel: StartViewModel

    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView
        contentView.delegate = self

    }

}
extension StartViewController: NextScreenStartViewDelegate {
    func nextScreenButtonDidPressed() {
        let signInVM: SignInViewModel = SignInViewModel()
        let signInVC = SignInViewController(viewModel: signInVM)
        navigationController?.pushViewController(signInVC, animated: true)
    }
}
