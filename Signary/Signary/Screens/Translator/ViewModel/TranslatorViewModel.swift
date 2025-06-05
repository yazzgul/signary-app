
import UIKit
import Combine

class TranslatorViewModel {

    @Published var showInvalidWordAlert = false
    @Published var showSomethingWentWrongAlert = false

    @Published var translateWordUIImagePublished: UIImage? = nil


    func translateWordWithUrl(word: String) {

        if !Validator.isValidWordForTranslate(for: word) {
//            alert
            showInvalidWordAlert = true
            return
        }
        Task {
            do {
//                let endpoint = EndPoint(valueForQuery: word)
//                if let img = try await NetworkRequest.shared.downloadImage(by: endpoint.requestForTranslatingWord)
                if let img = try await NetworkService.shared.translateWord(with: "https://american-sign-language-spelling-tool.p.rapidapi.com/\(word)?scale=5") {

                    self.translateWordUIImagePublished = img
                }
            } catch {
                print("Error in TranslatorViewModel translateWordWithUrl: ", error.localizedDescription)
//                alert
                showSomethingWentWrongAlert = true
            }
        }
    }

}
