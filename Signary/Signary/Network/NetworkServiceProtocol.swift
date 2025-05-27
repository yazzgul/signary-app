
import UIKit

protocol NetworkServiceProtocol {
    
    func translateWord(with url: String) async throws -> UIImage?

}
