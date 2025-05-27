
import UIKit

class NetworkService: NetworkServiceProtocol {

    static let shared = NetworkService()

    private let networkRequest = NetworkRequest()

    private init() {}

    func translateWord(with url: String) async throws -> UIImage? {
        return try await networkRequest.downloadTranslatedWordImage(by: url)
    }
}
