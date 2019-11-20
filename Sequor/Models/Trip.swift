import Foundation

struct Trip: Codable {
  var startDate: Date = Date()
  var endDate: Date?

  var locations: [Coordinate] = []

}

struct Coordinate: Codable {
  ///The latitude in degrees.
  var latitude: Double
  ///The longitude in degrees.
  var longitude: Double
}
