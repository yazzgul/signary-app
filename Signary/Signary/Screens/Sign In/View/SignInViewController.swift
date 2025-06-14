
import UIKit
import Combine

class SignInViewController: UIViewController {

    private var contentView: SignInView = .init()
    private let viewModel: SignInViewModel

    private var cancellables = Set<AnyCancellable>()

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
        
        NavigationBarAppearanceConfiguration.applyTitleView(to: navigationItem)
        navigationItem.hidesBackButton = true

        contentView.signUpDelegate = self
        contentView.mainScreenDelegate = self
        contentView.resetPasswordDelegate = self

        contentView.setupDelegateForTextFields(viewControllerDelegate: self)

        successfulySignIn()

        showEmailInvalidAlert()
        showSomethingWentWrongAlert()

    }
    func successfulySignIn() {
        viewModel.$successfulySignIn
            .sink { [weak self] userSuccessfulySignIn in
                if userSuccessfulySignIn {
                    self?.goToMainScreen()
                } else {
                    print("Что-то пошло не так! Не удалось войти.")
                }
            }
            .store(in: &cancellables)
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
extension SignInViewController: GoToSignUpScreenSignInViewDelegate {
    func goToSignUpScreenButtonDidPressed() {
        let vm = SignUpViewModel()
        let vc = SignUpViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension SignInViewController: SignInGoToMainScreenSignInViewDelegate {
    func signInButtonDidPressed(email: String, password: String) {
        viewModel.signInWithFirebase(email: email, password: password)
    }
}
extension SignInViewController: GoToResetPasswordScreenSignInViewDelegate {
    func goToResetPasswordScreenButtonDidPressed() {
        let vm = ResetPasswordViewModel()
        let vc = ResetPasswordViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension SignInViewController {
    func showEmailInvalidAlert() {
        viewModel.$showInvalidEmailAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showInvalidEmailAlert(on: self!)
                }
            }
            .store(in: &cancellables)
    }
    func showSomethingWentWrongAlert() {
        viewModel.$showSomethingWentWrongAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showSomethingWentWrongAlert(on: self!)
                }
            }
            .store(in: &cancellables)
    }
}
