
import UIKit

class MainTabBarController: UITabBarController {
    var mainVM: MainViewModel = MainViewModel()
    var profileVM: ProfileViewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true

        tabBar.tintColor = UIColor.darkPurple()
        tabBar.unselectedItemTintColor = UIColor.delicateBlue()

        let mainVC = MainViewController(viewModel: mainVM)
        let profileVC = ProfileViewController(viewModel: profileVM)

        let nav1 = UINavigationController(rootViewController: mainVC)
        let nav2 = UINavigationController(rootViewController: profileVC)

//        nav1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
//        nav2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        nav1.tabBarItem = UITabBarItem(title: "Main", image:  UIImage(systemName: "book"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image:  UIImage(systemName: "person"), tag: 1)


        viewControllers = [nav1, nav2]
    }
}
