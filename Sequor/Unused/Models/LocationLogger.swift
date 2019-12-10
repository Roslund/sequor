import CoreLocation

final class LocationLogger: NSObject, ObservableObject, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  var trip: Trip

  init(trip: Trip) {
    self.trip = trip

    super.init()
    locationManager.delegate = self
    locationManager.requestAlwaysAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.allowsBackgroundLocationUpdates = true
      // The minimum distance (measured in meters) a device must
      // move horizontally before an update event is generated.
      locationManager.distanceFilter = 5.0
      locationManager.pausesLocationUpdatesAutomatically = false
      locationManager.showsBackgroundLocationIndicator = true
      locationManager.requestLocation()
      locationManager.startUpdatingLocation()
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    trip.locations += locations.map { location in
      Location(timestamp: location.timestamp,
               speed: location.speed,
               course: location.course,
               coordinate: Coordinate(latitude: location.coordinate.latitude,
                                      longitude: location.coordinate.longitude)
      )
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }

  func end() -> Trip {
    locationManager.stopUpdatingLocation()
    trip.endDate = Date()
    return trip
  }
}
