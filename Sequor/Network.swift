import Foundation

enum HTTP {
  static func get(url: URL,
                  headers: [AnyHashable: Any]? = nil,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.httpAdditionalHeaders = headers

    let defaultSession = URLSession(configuration: configuration)
    let dataTask = defaultSession.dataTask(with: url, completionHandler: completionHandler)
    dataTask.resume()
  }

  static func get(url: URL,
                  headers: [AnyHashable: Any]? = nil,
                  completionHandler: @escaping (Data) -> Void) {
    get(url: url, headers: headers) { data, response, _ in
      if let data = data,
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 {
        completionHandler(data)
      }
    }
  }

  static func downloadTask(url: URL,
                           headders: [AnyHashable: Any]? = nil,
                           completionHandler: @escaping (Data) -> Void) {
    let configuration = URLSessionConfiguration.ephemeral
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

  static func post(data body: Data, to url: URL, headers: [String: String] = [:]) {
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

      // Expect JSON respone and just print it.
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
      }
    }
    task.resume()
  }

  static func post<Data: Encodable>(asJSON data: Data, to url: URL) {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970

    // Since the data conforms to codable we should be able to encode,
    // If not, we want the app to crash, so it's easier to debug.
    // swiftlint:disable:next force_try
    let json = try! encoder.encode(data)
    post(data: json, to: url, headers: ["Content-Type": "application/json"])
  }
}
