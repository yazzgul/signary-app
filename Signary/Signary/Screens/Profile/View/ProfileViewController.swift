
import UIKit
import Combine

class ProfileViewController: UIViewController {

    private var contentView: ProfileView = .init()
    private let viewModel: ProfileViewModel

    private var cancellables = Set<AnyCancellable>()


    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        updateUserProfileInfo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        navigationItem.title = "Profile"

        contentView.signOutDelegate = self
        contentView.deleteProfileDelegate = self
        contentView.learntWordsDelegate = self

    }

    func updateUserProfileInfo() {
        viewModel.currentUserPublisher
            .sink { [weak self] user in
                if let user = user {
                    self?.contentView.configureView(email: user.email, username: user.username)
                }
            }
            .store(in: &cancellables)
    }

//    func setupUserDataInProfile() {
//        
//        let email = viewModel.getUserEmail()
//        let username = viewModel.getUserUsername()
//
//        contentView.configureView(email: email, username: username)
//    }

    func goToStartScreen() {
        let startVM = StartViewModel()
        let startVC = StartViewController(viewModel: startVM)

        let navController = UINavigationController(rootViewController: startVC)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {

            window.rootViewController = navController
            window.makeKeyAndVisible()
        }
    }

}
extension ProfileViewController: GoToStartScreenSignOutProfileViewDelegate {
    func signOutButtonDidPressed() {
        viewModel.signOutFromProfile()

        goToStartScreen()
//        let startVM = StartViewModel()
//        let startVC = StartViewController(viewModel: startVM)
//
//        let navController = UINavigationController(rootViewController: startVC)
//
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let sceneDelegate = windowScene.delegate as? SceneDelegate,
//           let window = sceneDelegate.window {
//
//            window.rootViewController = navController
//            window.makeKeyAndVisible()
//        }
    }
}
extension ProfileViewController: DeleteProfileViewDelegate {
    func deleteProfileButtonDidPressed() {
        viewModel.deleteProfile { [weak self] success, error in
            if error != nil {
                print("Error in deleting user: deleteProfileButtonDidPressed")
            } else if success {
                self?.goToStartScreen()
            }
        }
    }
}
extension ProfileViewController: OpenLearntWordsListProfileViewDelegate {
    func learntWordsButtonDidPressed() {
        let vm = LearntWordsViewModel()
        let vc = LearntWordsViewController(viewModel: vm)

        navigationController?.pushViewController(vc, animated: true)
    }

}
