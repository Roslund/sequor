import Foundation

/// Simple HTTP "library"
enum HTTP {
  /// Get request with compleation handeler **with** error handeling
  static func get(url: URL, headers: [AnyHashable: Any]? = nil,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    // Configureation
    let configuration = URLSessionConfiguration.ephemeral
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    configuration.httpAdditionalHeaders = headers

    let defaultSession = URLSession(configuration: configuration)
    let dataTask = defaultSession.dataTask(with: url, completionHandler: completionHandler)
    dataTask.resume()
  }

  /// Get request with compleation handeler **without** error handeling
  static func get(url: URL, headers: [AnyHashable: Any]? = nil,
                  completionHandler: @escaping (Data) -> Void) {
    get(url: url, headers: headers) { data, response, _ in
      if let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 {
        completionHandler(data)
      }
    }
  }

  static func downloadTask(url: URL, headders: [AnyHashable: Any]? = nil,
                           completionHandler: @escaping (Data) -> Void) {
    // Configuration
    let configuration = URLSessionConfiguration.ephemeral
    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    configuration.httpAdditionalHeaders = headders
    configuration.shouldUseExtendedBackgroundIdleMode = true

    let defaultSession = URLSession(configuration: configuration)
    var dataTask: URLSessionDownloadTask

    dataTask = defaultSession
      .downloadTask(with: url) { url, response, _ in
        if let url = url,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          guard let data = try? Data(contentsOf: url) else {
            return
          }

          completionHandler(data)
        }
    }
    dataTask.resume()
  }

  /// Post request
  static func post(data body: Data, to url: URL,
                   additionalHeaders headers: [String: String] = [:],
                   completionHandler: @escaping (Data) -> Void) {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = body
    for (key, value) in headers {
      request.addValue(value, forHTTPHeaderField: key)
    }

    let task = URLSession.shared.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }

      completionHandler(data)
    }
    task.resume()
  }

  /// Encodes data as JSON and post json to url, with appropiate headers.
  static func post<POSTDATA: Encodable>(asJSON data: POSTDATA, to url: URL,
                                        completionHandler: @escaping (Data) -> Void) {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970

    // Since the data conforms to codable we should be able to encode,
    // If not, we want the app to crash, so it's easier to debug.
    // swiftlint:disable:next force_try
    let json = try! encoder.encode(data)
    post(data: json, to: url,
         additionalHeaders: ["Content-Type": "application/json"],
         completionHandler: completionHandler)
  }
}
