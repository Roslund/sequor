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
  let speed: Double
  /// Course 0-359.9 degrees
  let course: Double
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
