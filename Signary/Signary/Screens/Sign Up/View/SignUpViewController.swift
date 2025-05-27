
import UIKit
import Combine

class SignUpViewController: UIViewController {

    private var contentView: SignUpView = .init()
    private let viewModel: SignUpViewModel

    private var cancellable: AnyCancellable?

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
        contentView.signUpToMainScreenDelegate = self

        successfulySignUp()

    }
    func successfulySignUp() {
        cancellable = viewModel.$successfulySignUp
            .sink { [weak self] userSuccessfulySignUp in
                if userSuccessfulySignUp {
                    self?.goToMainScreen()
                } else {
                    print("Что то пошло не так! Не удалось зарегистрироваться.")
                }
            }
    }
    func goToMainScreen() {
        let tabBarController = MainTabBarController()
        //        navigationController?.pushViewController(tabBarController, animated: true)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {

            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }

}
extension SignUpViewController: BackToSignInScreenSignUpViewDelegate {
    func backToSignInButtonDidPressed() {
        navigationController?.popViewController(animated: true)
    }
}
extension SignUpViewController: SignUpGoToMainScreenSignUpViewDelegate {
    func signUpButtonDidPressed(username: String, email: String, password: String, passwordCheck: String) {
        viewModel.signUpWithFirebase(username: username, email: email, password: password, passwordCheck: passwordCheck)
    }
}
