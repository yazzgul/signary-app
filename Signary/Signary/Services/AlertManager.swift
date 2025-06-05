
import UIKit

class AlertManager {

    private static func showBasicAlert(on viewController: UIViewController, title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            viewController.present(alert, animated: true)
        }
    }

}
// validations alert
extension AlertManager {
    public static func showInvalidEmailAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Invalid Email", message: "Please enter a valid email (e.g., example@mail.com).")
    }
    public static func showInvalidUsernameAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Invalid Username", message: "Username must be 4–24 characters long and contain only letters, numbers, or underscores.")
    }
    public static func showInvalidPasswordAlert(on viewController: UIViewController) {
        self.showBasicAlert(
            on: viewController,
            title: "Invalid Password",
            message: "Password must be at least 8 characters long and include: 1 uppercase letter, 1 lowercase letter, 1 number, 1 special character (e.g., !@#$%)"
        )
    }
    public static func showNotEqualPasswordsAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Passwords are not equal", message: "Passwords do not match. Please enter the same password again.")
    }
    public static func showInvalidTranslatedWordAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Invalid word", message: "Please enter a single English word (1–24 letters, no numbers or symbols).")
    }
    public static func showEmailNotExistAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Invalid Email", message: "There is no such email registered.")
    }
    public static func showEmailWasRegisteredYetErrorAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Invalid Email", message: "Such an email has probably already been registered.")
    }
    public static func showSomethingWentWrongAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Something went wrong...", message: "Try again later.")
    }
    public static func showSendLetterToEmailPasswordResetAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Send a letter to email", message: "Please check your email and follow the rules.")
    }
    public static func showSuccessProfileDeletingAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Profile Deleted", message: "Your profile was deleted successfully.")
    }
    public static func showNotFoundCameraAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Error", message: "Camera not available.")
    }
    public static func showCannotCameraAccessAlert(on viewController: UIViewController) {
        self.showBasicAlert(on: viewController, title: "Camera access denied", message: "Please allow access to the camera.")
    }

}
