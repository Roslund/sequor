import Foundation

/// Should represent a continuous travel on public transport.
struct Trip: Codable {

  /// The date an time the tip started
  var startDate: Date = Date()

  /// The date an time the tip ended
  var endDate: Date?

  /// An array of locations captured durring the trip
  var locations: [Location] = []
}

/// A GPS location
struct Location: Codable {
  /// The timestam the location was recorded
  let timestamp: Date
  /// Speed at location (m/s)
  let speed: Double?
  /// Course 0-359.9 degrees
  let course: Double?
  /// The poistion
  let coordinate: Coordinate
}

/// Position represented by latitude and lognitude
struct Coordinate: Codable {
  ///The latitude in degrees.
  let latitude: Double
  ///The longitude in degrees.
  let longitude: Double
}

extension Array where Element == Trip {
    /// **Warning, Do not use**. Should only be used by the sharesheet extention in _PurchaseView.swift_
    /// Should be removed at some later point
    func asJSONString() -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        // swiftlint:disable:next force_try
        return String(data: try! encoder.encode(self), encoding: .utf8)!

    }
}
