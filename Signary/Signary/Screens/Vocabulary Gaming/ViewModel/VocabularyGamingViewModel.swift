
import UIKit

class VocabularyGamingViewModel {

//    @Published var userLearntWords: [String] = []

    var unlearntWords: [Word] = []
    @Published var currentUnlearntWord: Word?


    func getLearntWordsLists() {

        guard let curUser = UserService.shared.currentUser else { return }

        let userLearntWordsList = curUser.learntWords
        print(userLearntWordsList)

        if !userLearntWordsList.isEmpty {
            unlearntWords = WordListService.shared.filterUnlearntWords(from: WordListService.shared.words, learntWords: userLearntWordsList)

            print(unlearntWords)
        } else {
            unlearntWords = WordListService.shared.words
        }
        if !unlearntWords.isEmpty {
            currentUnlearntWord = unlearntWords[0]
        }
    }

    func checkSubmitWord(word: String) {
        if word.isEmpty {
            return
        }

        guard let currentUnlearntWordUnwrapped = currentUnlearntWord  else { return }

//        let cleaned = word.trimmingCharacters(in: .whitespacesAndNewlines)
//        let formattedWord = cleaned.prefix(1).uppercased() + cleaned.dropFirst()

        let cleaned = word.trimmingCharacters(in: .whitespacesAndNewlines)
        let reducedSpaces = cleaned.components(separatedBy: .whitespacesAndNewlines)
                                      .filter { !$0.isEmpty }
                                      .joined(separator: " ")
        let formattedWord = reducedSpaces.prefix(1).uppercased() + reducedSpaces.dropFirst()

        if formattedWord != currentUnlearntWordUnwrapped.name {
            return
        }

        let curUser = UserService.shared.getCurrentUser()

        if var curUser = curUser {

            curUser.learntWords.append(currentUnlearntWordUnwrapped.name)

/// обновляем информацию про пользователя на удаленном сервере (firebase)
            AuthService.shared.updateUserInfoInFirebase(with: curUser) { _, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
/// обновляем информацию про пользователя в локальном сервисе пользователя
                    UserService.shared.updateCurrentLocalUser(curUser)
                    print("info about user was successfully updated!")
                }
            }
/// логика для сетапа нового слова для изучения
            if let index = unlearntWords.firstIndex(where: { $0.name == currentUnlearntWordUnwrapped.name }) {
                let nextIndex = index + 1
                if nextIndex < unlearntWords.count {
                    currentUnlearntWord = unlearntWords[nextIndex]
                    print("Следующее слово: \(currentUnlearntWord?.name ?? "No word")")
                } else {
                    currentUnlearntWord = nil
                    print("Следующего слова нет — достигнут конец массива.")
                }
            }

        }

    }
    

}
