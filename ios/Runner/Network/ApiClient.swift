import Foundation

class ApiClient {
    private let session: URLSession

    init() {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }

    func request(
        baseUrl: String,
        path: String,
        method: String,
        queryParams: [String: Any]?,
        headers: [String: String]?,
        completion: @escaping ([String: Any?]) -> Void
    ) {
        guard var urlComponents = URLComponents(string: "\(baseUrl)\(path)") else {
            completion([
                "statusCode": 0,
                "data": nil,
                "error": "Invalid URL: \(baseUrl)\(path)"
            ])
            return
        }

        if let queryParams = queryParams, !queryParams.isEmpty {
            urlComponents.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }

        guard let url = urlComponents.url else {
            completion([
                "statusCode": 0,
                "data": nil,
                "error": "Failed to construct URL"
            ])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.uppercased()

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion([
                        "statusCode": 0,
                        "data": nil,
                        "error": error.localizedDescription
                    ])
                }
                return
            }

            let httpResponse = response as? HTTPURLResponse
            let statusCode = httpResponse?.statusCode ?? 0

            guard let data = data else {
                DispatchQueue.main.async {
                    completion([
                        "statusCode": statusCode,
                        "data": nil,
                        "error": "No data received"
                    ])
                }
                return
            }

            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                DispatchQueue.main.async {
                    completion([
                        "statusCode": statusCode,
                        "data": nil,
                        "error": "Failed to parse JSON response"
                    ])
                }
                return
            }

            guard (200...299).contains(statusCode) else {
                let errorMessage = (json["status_message"] as? String) ?? "Request failed with status \(statusCode)"
                DispatchQueue.main.async {
                    completion([
                        "statusCode": statusCode,
                        "data": nil,
                        "error": errorMessage
                    ])
                }
                return
            }

            DispatchQueue.main.async {
                completion([
                    "statusCode": statusCode,
                    "data": json,
                    "error": nil
                ])
            }
        }
        task.resume()
    }
}
