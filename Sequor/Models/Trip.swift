import Foundation

struct Trip: Codable {
  var startDate: Date = Date()
  var endDate: Date?

  var locations: [Location] = []
}

struct Location: Codable {
  /// The timestam the location was recorded
  let timestamp: Date
  /// Speed at location (m/s)
  let speed: Double
  /// Course 0-359.9 degrees
  let course: Double
  /// The poistion
  let coordinate: Coordinate
}

struct Coordinate: Codable {
  ///The latitude in degrees.
  let latitude: Double
  ///The longitude in degrees.
  let longitude: Double
}
