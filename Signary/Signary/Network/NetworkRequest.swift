
import UIKit

class NetworkRequest {

    func downloadTranslatedWordImage(by urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }

        print("1")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("0a7c09b4bbmsh37a0ffbd05b9157p163732jsn3a98fcd0ce87", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("american-sign-language-spelling-tool.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
        }
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Invalid response")
            print("2")

            return nil
        }

        guard let image = UIImage(data: data) else {
            print("Data is not a valid image")
            print("3")

            return nil
        }
        print("4")

        print(image)
        return image
    }

}

