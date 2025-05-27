
import Foundation
import Combine

class ProfileViewModel {

//    UserDefaults.standard.bool(forKey: "isLogged")
//    userDefaults.removeObject(forKey: "isLogged")
//    userDefaults.setValue(true, forKey: "isLogged")

    init() {
        UserService.shared.getUserFromDatabase()
    }

    var currentUserPublisher: AnyPublisher<UserInSignary?, Never> {
        return UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    func getUserEmail() -> String {
        UserService.shared.getCurrentUserEmail() ?? "No found"
    }
    func getUserUsername() -> String {
        UserService.shared.getCurrentUserUsername() ?? "No found"
    }

    func signOutFromProfile() {
        AuthService.shared.signOut { successInOut, error in
            if let error = error {
                print("Error in ProfileViewModel: \(error.localizedDescription)")
//                alert
                return
            }
            if successInOut {
//                for default logic
                UserDefaults.standard.removeObject(forKey: "isLogged")
            }
        }
    }
    func deleteProfile(completion: @escaping (Bool, Error?) -> Void) {
        AuthService.shared.deleteUser { error in
            if let error = error {
                print("Error in ProfileViewModel: \(error.localizedDescription)")
//                alert
                completion(false, error)
            } else {
                completion(true, nil)
                UserDefaults.standard.removeObject(forKey: "isLogged")
            }
        }
    }

}
