
import Foundation
import Combine

class UserService {
    static let shared = UserService()

    private init() { }

    @Published var currentUser: UserInSignary?

    public func getUserFromDatabase() {
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

    func getCurrentUserLearntWords() -> [String]? {
        return currentUser?.learntWords
    }

    func setNewLearntWordsList(_ words: [String]) {
        currentUser?.learntWords = words
    }
    func addNewLearntWordToUserList(_ word: String) {
        currentUser?.learntWords.append(word)
    }
    func updateCurrentLocalUser(_ user: UserInSignary) {
        currentUser = user
    }


}
