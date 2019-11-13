import SwiftUI
import MapKit

/// A fullscreen MKMapView without interaction that follows the users location
final class MapView: NSObject, UIViewRepresentable, MKMapViewDelegate {

    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = self
        return view
    }

    func mapViewDidFinishLoadingMap(_ view: MKMapView) {
        view.showsUserLocation = true
        view.userTrackingMode = .follow
        view.isUserInteractionEnabled = false
    }

    // Updates the presented UIKit view to the latest configuration. **Required**.
    // Probably better to use the delegate methods instead.
    func updateUIView(_ view: MKMapView, context: Context) {
    }
}

struct MapViewPreview: PreviewProvider {
    static var previews: some View {
        MapView().edgesIgnoringSafeArea(.vertical)
    }
}
