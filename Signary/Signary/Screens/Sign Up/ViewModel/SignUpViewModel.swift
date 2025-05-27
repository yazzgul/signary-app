
import Foundation
import Combine

class SignUpViewModel {
    @Published var successfulySignUp = false

    func signUpWithFirebase(username: String, email: String, password: String, passwordCheck: String) {
//        var emailValid = ""
//        var usernameValid = ""
//        var passwordValid = ""
//        var passwordCheckValid = ""

//        if Validator.isValidEmail(for: email) {
//            emailValid = email
//        } else {
////            alert
//            return
//        }
//        if Validator.isValidUsername(for: username) {
//            usernameValid = username
//        } else {
////            alert
//            return
//        }
//        if Validator.isValidPassword(for: password) {
//            passwordValid = password
//        } else {
////            alert
//            return
//        }
//        if Validator.isValidPassword(for: passwordCheck) {
//            passwordCheckValid = passwordCheck
//        } else {
////            alert
//            return
//        }

        if !Validator.isValidEmail(for: email) {
//            alert
            return
        }
        if !Validator.isValidUsername(for: username) {
//            alert
            return
        }
        if !Validator.isValidPassword(for: password) {
//            alert
            return
        }
        if !Validator.isValidPassword(for: passwordCheck) {
//            alert
            return
        }

        if Validator.isValidTwoPasswordEqual(password: password, passwordAgain: passwordCheck) {
            let user = UserRegisterRequest(username: username, email: email, password: password)

            AuthService.shared.signUp(with: user) { wasRegistered, error in
                if let error = error {
                    print("error in sign up view model: \(error.localizedDescription)")
//                    alert
                    return
                }
                if wasRegistered {
                    self.successfulySignUp = true
                    UserDefaults.standard.setValue(true, forKey: "isLogged")
                }
            }

        } else {
//            alert not equal passwords
        }

    }

}
