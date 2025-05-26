
import Foundation

class ResetPasswordViewModel {

    func resetPasswordWithFirebaseEmail(email: String) {

        if !Validator.isValidEmail(for: email) {
//            alert
            return
        }

        AuthService.shared.forgotPassword(with: email) { error in
            if let error = error {
                print("Error in ResetPasswordViewModel: \(error.localizedDescription)")
//                alert
                return
            } else {
//                alert: check email
            }
        }
    }

}
