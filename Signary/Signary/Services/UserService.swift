
import Foundation
import Combine

class UserService {
    static let shared = UserService()

    private init() { }

    @Published var currentUser: UserInSignary?

    func getUserFromDatabase() {
        AuthService.shared.fetchUser { [weak self] user, error in
            if let error = error {
                print("Error in UserService: \(error.localizedDescription)")
                return
            }
            if let user = user {
                self?.currentUser = user
                print("UserService currentUser?.email \(String(describing: self?.currentUser?.email))")

            }
        }
    }

    func getCurrentUserUsername() -> String? {
        return currentUser?.username
    }
    func getCurrentUserEmail() -> String? {
        return currentUser?.email
    }
    func getCurrentUser() -> UserInSignary? {
        return currentUser
    }


}
