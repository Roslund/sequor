import CoreLocation
import CoreMotion
import MapKit

/// Used for recording location data.
/// Uses CoreMotion to classify the activity and only store trip information when travling on a automotive vheicle.
final class TripSegmentator: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let activityManager = CMMotionActivityManager()

    /// Keeps track on when to stop tracking. Normaly at the tickets experation
    private var timer: Timer?

    /// mapView to update with new location and classification data.
    weak var mapView: MKMapView?
    private var previousCoordinate: CLLocationCoordinate2D?

    /// Only used for debugging and showing information on the debug map
    var segments: [LocationsSegment] = []

    /// The identified motion activity
    @Published var activity: CMMotionActivity.Classification = .unknown

    /// Stores trips durring the tracking session
    var trips: [Trip] = []

    /// Initializer.
    /// Also sets up the locationmanager. Maybe this should be at a later point? We'll have to test
    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.pausesLocationUpdatesAutomatically = false

            // The minimum distance (measured in meters) a device must
            // move horizontally before an update event is generated.
            locationManager.distanceFilter = 10.0

            // No need to triger locationupdates when changing heading.
            // Found no way to turn this off, but a 360 degree change should be rare.
            locationManager.headingFilter = 359.9

            // Just true for testing, making sure that the app records data in the background.
            locationManager.showsBackgroundLocationIndicator = true
        }
    }

    /// Delegate method called when new location data is available.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // For live updates of the MKMapView
        if let coordinate = previousCoordinate, mapView != nil {
            var area = [coordinate] + locations.map({$0.coordinate})
            let polyline = MKPolyline(coordinates: &area, count: area.count)

            // The title is used to color the line segment on the map.
            polyline.title = self.activity.rawValue
            mapView?.addOverlay(polyline)
        }

        // Just used for the line updates on the MKMapView.
        // However we need to keep track of it, even if we're currently not showing the mapview.
        if let coordinate = locations.last?.coordinate {
            previousCoordinate = coordinate
        }

        // Filter out any reading with too poor accuracy. These should be locations derermined by cell tower
        // or wifi triangulation. Or GPS Positions when the user is inside or underground.
        // Someone said that less that 360 is garanteed to use the devices gps.
        let locations = locations.filter { location in
            location.horizontalAccuracy < 360
        }

        // Storing segments to display historic info on the map
        if !segments.isEmpty {
            segments[segments.count-1].coordinates.append(contentsOf: locations.map({$0.coordinate}))
        }

        // We only want to store trip data when the user is automotive (or cycling)
        if activity == .cycling || activity == .automotive {
            trips[trips.count-1].locations.append(contentsOf: locations.map { location in
                Location(timestamp: location.timestamp, speed: location.speed, course: location.course,
                         coordinate: Coordinate(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude))
            })
        }

    }

    /// Required function. If something fails we just print it.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    /// Will classify the users activity and store trip data untill `stopMinitoring()` is called.
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

                // If the new activity is not automotive (or cycling) end the trip
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

    /// Stops monitoring and empties logged trips and segments.
    func stopMonitoring() {
        activityManager.stopActivityUpdates()
        locationManager.stopUpdatingLocation()
        // Remove any existing segments
        // Should probably send segments where activity is automotive to backend as trips :D
        segments = []
        trips = []
    }
}
