import CoreMotion
import CoreLocation

/// Structure for displaying trip segments on a MKMapView
struct LocationsSegment {
    let activity: CMMotionActivity.Classification
    var coordinates: [CLLocationCoordinate2D] = []
}
