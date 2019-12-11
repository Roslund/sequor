import CoreMotion
import CoreLocation

/// Structure for displaying trip segments on a MKMapView
struct LocationsSegment {
    /// The classified user activity.
    let activity: CMMotionActivity.Classification
    /// All logged cordinates for this segment.
    var coordinates: [CLLocationCoordinate2D] = []
}
