import CoreLocation
import CoreMotion
import MapKit

final class TripSegmentator: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let activityManager = CMMotionActivityManager()

    /// Only used for debugging and showing information on the debug map
    var segments: [LocationsSegment] = []
    weak var mapView: MKMapView?
    var previousCoordinate: CLLocationCoordinate2D?

    @Published var activity: CMMotionActivity.Classification = .unknown
    var trips: [Trip] = []

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            // The minimum distance (measured in meters) a device must
            // move horizontally before an update event is generated.
            locationManager.distanceFilter = 10.0
            // Try not to update on heading change
            locationManager.headingFilter = 359.9
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.showsBackgroundLocationIndicator = true
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Storing segments to display historic info on the map
        if !segments.isEmpty {
            segments[segments.count-1].coordinates.append(contentsOf: locations.map({$0.coordinate}))
        }

        // For live updates of the MKMapView
        if let coordinate = previousCoordinate, mapView != nil {
            var area = locations.map({$0.coordinate}) + [coordinate]
            let polyline = MKPolyline(coordinates: &area, count: area.count)
            polyline.title = self.activity.rawValue
            mapView?.addOverlay(polyline)
            previousCoordinate = locations.last?.coordinate
        }

        if activity == .cycling || activity == .automotive {
            trips[trips.count-1].locations.append(contentsOf: locations.map { location in
                Location(timestamp: location.timestamp, speed: location.speed, course: location.course,
                         coordinate: Coordinate(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude))
            })
        }

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func startMonitoring() {
        // Activity Manager
        activityManager.startActivityUpdates(to: .main) { (activity) in
            guard let activity = activity else {
                return
            }
            let newActivity = activity.classification

            // If we are higliy confident that the new activity is something different, or walking
            if self.activity != newActivity && (activity.confidence == .high || newActivity == .walking) {
                self.activity = newActivity

                // Update segments
                self.segments.append(LocationsSegment(activity: newActivity))

                // If the new activity is not automotive or cycling
                if self.activity != .cycling || self.activity != .automotive {
                    if !self.trips.isEmpty {
                        self.trips[self.trips.count-1].endDate = Date()
                    }
                }
                // If the new activity is automotive (or cycling) start a new trip
                if self.activity == .cycling || self.activity == .automotive {
                    self.trips.append(Trip())
                }
            }
        }

        // Location Manager
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        self.previousCoordinate = locationManager.location?.coordinate
    }

    func stopMonitoring() {
        activityManager.stopActivityUpdates()
        locationManager.stopUpdatingLocation()
        // Remove any existing segments
        // Should probably send segments where activity is automotive to backend as trips :D
        segments = []
        trips = []
    }
}
