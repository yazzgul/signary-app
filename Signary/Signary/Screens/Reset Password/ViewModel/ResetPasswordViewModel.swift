
import Foundation

class ResetPasswordViewModel {

    @Published var showInvalidEmailAlert = false
    @Published var showSomethingWentWrongAlert = false
    @Published var showCheckEmailAlert = false

    func resetPasswordWithFirebaseEmail(email: String) {

        if !Validator.isValidEmail(for: email) {
//            alert
            showInvalidEmailAlert = true
            return
        }

        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            if let error = error {
                print("Error in ResetPasswordViewModel: \(error.localizedDescription)")
//                alert
                self?.showSomethingWentWrongAlert = true
                return
            } else {
//                alert: check email
                self?.showCheckEmailAlert = true
            }
        }
    }

}
