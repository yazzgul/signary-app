
import Foundation

class LearntWordsDetailViewModel {

    var selectedWord: Word?

    func setSelectedWord() {
        if let word = WordListService.shared.getFullSelectedWord() {
            selectedWord = word
        }
    }

    func getSelectedWord() -> Word? {
        if let word = WordListService.shared.getFullSelectedWord() {
            return word
        }
        return nil
    }

}
