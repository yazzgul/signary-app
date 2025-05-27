
import Foundation

struct EndPoint {
    
    let valueForQuery: String

    var requestForTranslatingWord: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "american-sign-language-spelling-tool.p.rapidapi.com"
        components.path = "/\(valueForQuery)"
        components.queryItems = [
            URLQueryItem(name: "scale", value: "5")
        ]

        guard let url = components.url else {
            preconditionFailure("Invalid URL components")
        }

//        print("Request URL: \(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("0a7c09b4bbmsh37a0ffbd05b9157p163732jsn3a98fcd0ce87", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("american-sign-language-spelling-tool.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        return request
    }

}
