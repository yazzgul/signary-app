
import Foundation

class MainViewModel {
    func loadUser() {
        UserService.shared.getUserFromDatabase()
    }
}
