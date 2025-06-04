
import UIKit

class WordListService {

    public static let shared = WordListService()

    private init() {}

    public var selectedLearntWord: String?

    public var words: [Word] = [
        Word(id: 1, name: "Hello", signImages: UIImage(named: "hello")!),
        Word(id: 2, name: "Help", signImages: UIImage(named: "help")!),
        Word(id: 3, name: "Bathroom", signImages: UIImage(named: "bathroom")!),
        Word(id: 4, name: "I love you", signImages: UIImage(named: "i-love-you")!),
        Word(id: 5, name: "Sorry", signImages: UIImage(named: "sorry")!)
    ]

    func getWords() -> [Word] {
        return words
    }
    func addWordToArray(_ word: Word) {
        words.append(word)
    }
    func setupNewArray(_ array: [Word]) {
        words = array
    }

    /// фильтрация для получения неизвестных слов
    func filterUnlearntWords(from allWords: [Word], learntWords: [String]) -> [Word] {
        let learntSet = Set(learntWords.map { $0.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) })
        return allWords.filter {
            let wordName = $0.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return !learntSet.contains(wordName)
        }
    }

    func getFullSelectedWord() -> Word? {
        if let word = words.first(where: { $0.name == selectedLearntWord }) {
            return word
        }
        return nil
    }

}
