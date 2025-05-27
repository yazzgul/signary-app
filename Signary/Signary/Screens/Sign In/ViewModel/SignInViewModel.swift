
import Foundation

class SignInViewModel {
    @Published var successfulySignIn = false

    func signInWithFirebase(email: String, password: String) {
//        var emailValid = ""
//        var passwordValid = ""

        if !Validator.isValidEmail(for: email) {
//            alert
            return
        }

        let user = UserLoginRequest(email: email, password: password)

        AuthService.shared.signIn(with: user) { wasSuccesInSignIn, error in
            if let error = error {
                print("error in sign in view model: \(error.localizedDescription)")
//                    alert
                return
            }
            if wasSuccesInSignIn {
                self.successfulySignIn = true
                UserDefaults.standard.setValue(true, forKey: "isLogged")
            }
        }

    }
}
