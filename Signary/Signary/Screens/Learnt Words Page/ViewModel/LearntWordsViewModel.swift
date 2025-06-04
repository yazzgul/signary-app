
import UIKit
import Combine

class LearntWordsViewModel {

    @Published var userLearntWords: [String] = []

    func getLearntWordsList() {
        guard let userLearntWordsList = UserService.shared.getCurrentUserLearntWords() else { return }
        userLearntWords = userLearntWordsList

    }

    func saveCurrentLearntWordTableSelected(didSelectRowAt indexPath: IndexPath) {
        let word = userLearntWords[indexPath.row]

        WordListService.shared.selectedLearntWord = word
    }

}
extension LearntWordsViewModel {
    func numberOfRowsInSection() -> Int {
        return userLearntWords.count
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: LearntWordsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? LearntWordsTableViewCell
        guard let cell = cell else { return UITableViewCell() }

        let word = userLearntWords[indexPath.row]

        cell.configureCell(with: word)

        return cell
    }

    func deleteByLeftSwipe(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in

            self?.deleteLearntWordFromList(by: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .left)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func deleteLearntWordFromList(by arrayIndex: Int) {
        let curUser = UserService.shared.getCurrentUser()

        if var curUser = curUser {
            let word = userLearntWords[arrayIndex]

            guard let index = curUser.learntWords.firstIndex(of: word) else { return }

            userLearntWords.remove(at: index)
            curUser.learntWords.remove(at: index)

//  обновляем информацию про пользователя на удаленном сервере (firebase)
            AuthService.shared.updateUserInfoInFirebase(with: curUser) { _, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
//  обновляем информацию про пользователя в локальном сервисе пользователя
                    UserService.shared.updateCurrentLocalUser(curUser)
                    print("info about user was successfully updated!")
                }
            }
        }
    }

}
