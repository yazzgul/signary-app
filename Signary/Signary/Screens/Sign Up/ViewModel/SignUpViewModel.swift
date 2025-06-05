
import Foundation
import Combine

class SignUpViewModel {
    @Published var successfulySignUp = false

    @Published var showInvalidEmailAlert = false
    @Published var showInvalidUsernameAlert = false
    @Published var showInvalidPasswordAlert = false
    @Published var showNotEqualPasswordsAlert = false
    @Published var showSomethingWentWrongAlert = false

    func signUpWithFirebase(username: String, email: String, password: String, passwordCheck: String) {

        if !Validator.isValidEmail(for: email) {
//            alert
            showInvalidEmailAlert = true
            return
        }
        if !Validator.isValidUsername(for: username) {
//            alert
            showInvalidUsernameAlert = true
            return
        }
        if !Validator.isValidPassword(for: password) {
//            alert
            showInvalidPasswordAlert = true
            return
        }
        if !Validator.isValidPassword(for: passwordCheck) {
//            alert
            showInvalidPasswordAlert = true
            return
        }

        if Validator.isValidTwoPasswordEqual(password: password, passwordAgain: passwordCheck) {
            let user = UserRegisterRequest(username: username, email: email, password: password)

            AuthService.shared.signUp(with: user) { [weak self] wasRegistered, error in
                if let error = error {
                    print("error in sign up view model: \(error.localizedDescription)")
//                    alert
                    self?.showSomethingWentWrongAlert = true
                    return
                }
                if wasRegistered {
                    self?.successfulySignUp = true
                    UserDefaults.standard.setValue(true, forKey: "isLogged")
                }
            }

        } else {
//            alert not equal passwords
            showNotEqualPasswordsAlert = true
            return
        }

    }

}
