import Foundation

enum HTTP {
  static func get(url: URL,
                  headders: [AnyHashable: Any]? = nil,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.httpAdditionalHeaders = headders

    let defaultSession = URLSession(configuration: configuration)
    let dataTask = defaultSession.dataTask(with: url, completionHandler: completionHandler)
    dataTask.resume()
  }

  static func get(url: URL,
                  headders: [AnyHashable: Any]? = nil,
                  completionHandler: @escaping (Data) -> Void) {
    get(url: url) { data, response, _ in
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

  static func post(data body: Data, to url: URL) {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = body
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.dataTask(with: request) { data, _, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
      if let responseJSON = responseJSON as? [String: Any] {
        print(responseJSON)
      }
    }
    task.resume()
  }

  static func post(asJSON data: Trip, to url: URL) {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .secondsSince1970
    // swiftlint:disable:next force_try
    let json = try! encoder.encode(data)
    print(String(data: json, encoding: .utf8)!)
    post(data: json, to: url)

    [1,2].firstIndex(of: 4)
  }
}
