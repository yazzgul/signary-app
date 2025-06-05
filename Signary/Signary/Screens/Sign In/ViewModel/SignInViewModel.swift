
import Foundation

class SignInViewModel {
    @Published var successfulySignIn = false
    @Published var showInvalidEmailAlert = false
    @Published var showSomethingWentWrongAlert = false

    func signInWithFirebase(email: String, password: String) {
//        var emailValid = ""
//        var passwordValid = ""

        if !Validator.isValidEmail(for: email) {
//            alert
            showInvalidEmailAlert = true
            return
        }

        let user = UserLoginRequest(email: email, password: password)

        AuthService.shared.signIn(with: user) { [weak self] wasSuccesInSignIn, error in
            if let error = error {
                print("error in sign in view model: \(error.localizedDescription)")
//                    alert
                self?.showSomethingWentWrongAlert = true
                return
            }
            if wasSuccesInSignIn {
                self?.successfulySignIn = true
                UserDefaults.standard.setValue(true, forKey: "isLogged")
            }
        }

    }
}
