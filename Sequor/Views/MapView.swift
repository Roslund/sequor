import SwiftUI
import MapKit

/// A fullscreen MKMapView without interaction that follows the users location
final class MapView: NSObject, UIViewRepresentable, MKMapViewDelegate {
    var tripSegmentator: TripSegmentator!

    convenience init(tripSegmentator: TripSegmentator) {
        self.init()
        self.tripSegmentator = tripSegmentator
    }

    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = self
        tripSegmentator.mapView = view
        return view
    }

    func mapViewDidFinishLoadingMap(_ view: MKMapView) {
        view.showsUserLocation = true
        view.userTrackingMode = .follow
        view.isUserInteractionEnabled = true

        // Should add all overlays
        for segment in tripSegmentator.segments {
            var area = segment.coordinates
            let polyline = MKPolyline(coordinates: &area, count: area.count)
            polyline.title = segment.activity.rawValue
            view.addOverlay(polyline)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            switch overlay.title {
            case "walking":
                renderer.strokeColor = .green
            case "running":
                renderer.strokeColor = .red
            case "cycling":
                renderer.strokeColor = .yellow
            case "automotive":
                renderer.strokeColor = .blue
            default:
                renderer.strokeColor = .gray
            }
            renderer.lineWidth = 5
            return renderer
        }
        fatalError("Unknow Overlay")
    }

    // Probably better to use the delegate methods instead.
    /// Updates the presented UIKit view to the latest configuration. **Required**.
    func updateUIView(_ view: MKMapView, context: Context) {
    }
}

struct MapViewPreview: PreviewProvider {
    static var previews: some View {
        MapView().edgesIgnoringSafeArea(.vertical)
    }
}
