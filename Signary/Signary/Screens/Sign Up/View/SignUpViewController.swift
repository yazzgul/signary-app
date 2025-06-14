
import UIKit
import Combine

class SignUpViewController: UIViewController {

    private var contentView: SignUpView = .init()
    private let viewModel: SignUpViewModel

    private var cancellables = Set<AnyCancellable>()

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

        NavigationBarAppearanceConfiguration.applyTitleView(to: navigationItem)
        navigationItem.hidesBackButton = true
        
        contentView.signInDelegate = self
        contentView.signUpToMainScreenDelegate = self

        contentView.setupDelegateForTextFields(viewControllerDelegate: self)

        successfulySignUp()

        showSomethingWentWrongAlert()
        showInvalidEmailAlert()
        showInvalidUsernameAlert()
        showInvalidPasswordAlert()
        showNotEqualPasswordsAlert()

    }
    func successfulySignUp() {
        viewModel.$successfulySignUp
            .sink { [weak self] userSuccessfulySignUp in
                if userSuccessfulySignUp {
                    self?.goToMainScreen()
                } else {
                    print("Что то пошло не так! Не удалось зарегистрироваться.")
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
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension SignUpViewController {
    func showSomethingWentWrongAlert() {
        viewModel.$showSomethingWentWrongAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showSomethingWentWrongAlert(on: self!)
                }
                print(bool)
            }
            .store(in: &cancellables)
    }
    func showInvalidEmailAlert() {
        viewModel.$showInvalidEmailAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showInvalidEmailAlert(on: self!)
                }
                print(bool)
            }
            .store(in: &cancellables)
    }
    func showInvalidUsernameAlert() {
        viewModel.$showInvalidUsernameAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showInvalidUsernameAlert(on: self!)
                }
                print(bool)
            }
            .store(in: &cancellables)
    }
    func showInvalidPasswordAlert() {
        viewModel.$showInvalidPasswordAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showInvalidPasswordAlert(on: self!)
                }
                print(bool)
            }
            .store(in: &cancellables)
    }
    func showNotEqualPasswordsAlert() {
        viewModel.$showNotEqualPasswordsAlert
            .sink { [weak self] bool in
                if bool {
                    AlertManager.showNotEqualPasswordsAlert(on: self!)
                }
                print(bool)
            }
            .store(in: &cancellables)
    }
}
