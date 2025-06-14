
import Foundation
import Combine

class ProfileViewModel {

    @Published var showSomethingWentWrongAlert = false
    @Published var showSuccessProfileDeletingAlert = false

//    func loadUser() {
//        UserService.shared.getUserFromDatabase()
//    }

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
        AuthService.shared.signOut { [weak self] successInOut, error in
            if let error = error {
                print("Error in ProfileViewModel: \(error.localizedDescription)")
//                alert
                self?.showSomethingWentWrongAlert = true
                return
            }
            if successInOut {
                UserDefaults.standard.removeObject(forKey: "isLogged")
            }
        }
    }
    func deleteProfile(completion: @escaping (Bool, Error?) -> Void) {
        AuthService.shared.deleteUser { [weak self] error in
            if let error = error {
                print("Error in ProfileViewModel: \(error.localizedDescription)")
//                alert
                completion(false, error)
                self?.showSomethingWentWrongAlert = true
            } else {
                completion(true, nil)
                UserDefaults.standard.removeObject(forKey: "isLogged")
                self?.showSuccessProfileDeletingAlert = true
            }
        }
    }

}
