import Foundation

/// Simple HTTP "library"
enum HTTP {
  enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
  }

//  static func downloadTask(url: URL, headders: [AnyHashable: Any]? = nil,
//                           completionHandler: @escaping (Data) -> Void) {
//    // Configuration
//    let configuration = URLSessionConfiguration.ephemeral
//    configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//    configuration.httpAdditionalHeaders = headders
//    configuration.shouldUseExtendedBackgroundIdleMode = true
//
//    let defaultSession = URLSession(configuration: configuration)
//    var dataTask: URLSessionDownloadTask
//
//    dataTask = defaultSession
//      .downloadTask(with: url) { url, response, _ in
//        if let url = url,
//          let response = response as? HTTPURLResponse,
//          response.statusCode == 200 {
//          guard let data = try? Data(contentsOf: url) else {
//            return
//          }
//
//          completionHandler(data)
//        }
//    }
//    dataTask.resume()
//  }

  /// Request with compleation handeler **with** error handeling
  static func request(method: Method = .GET, url: URL, body: Data? = nil,
                      additionalHeaders headers: [String: String] = [:],
                      completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.httpBody = body
    request.cachePolicy = .reloadIgnoringLocalCacheData
    for (key, value) in headers {
      request.addValue(value, forHTTPHeaderField: key)
    }

    let task = URLSession.shared.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
  }

  /// Request with compleation handeler **with** error handeling
  static func request(method: Method = .GET, url: URL, body: Data? = nil,
                      additionalHeaders headers: [String: String] = [:],
                      completionHandler: @escaping (Data) -> Void) {
    request(method: method, url: url, body: body, additionalHeaders: headers) { data, _, error in
      guard let data = data, error == nil else {
        print(error?.localizedDescription ?? "No data")
        return
      }
      completionHandler(data)
    }
  }

  /// Request **with out** compleation handeler
  static func request(method: Method = .GET, url: URL, body: Data? = nil,
                      additionalHeaders headers: [String: String] = [:]) {
    request(method: method, url: url, body: body, additionalHeaders: headers) { _, _, _ in }
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

    request(method: .POST, url: url, body: json,
            additionalHeaders: ["Content-Type": "application/json"],
            completionHandler: completionHandler)
  }
}
