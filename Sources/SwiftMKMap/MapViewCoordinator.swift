import MapKit
import SwiftUI

public class MapViewCoordinator: NSObject, MKMapViewDelegate {
    deinit {}

    public typealias MapView = SwiftMKMapView

    private let mapView: MapView

    public init(_ control: MapView) {
        self.mapView = control
    }

    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.mapView.region = mapView.region
    }

    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        if self.mapView.annotationImage == nil {
            return nil
        }
        let identifier: String = "marker"
        let annotationView: MKAnnotationView = .init(annotation: annotation, reuseIdentifier: identifier)
        annotationView.image = self.mapView.annotationImage
        annotationView.annotation = annotation
        return annotationView
    }

    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let polylineRenderer: MKPolylineRenderer = .init(polyline: polyline)
            polylineRenderer.strokeColor = self.mapView.strokeColor ?? UIColor(.accentColor)
            polylineRenderer.lineWidth = self.mapView.strokeWeight ?? 4.0 as CGFloat
            return polylineRenderer
        }

        return MKOverlayRenderer()
    }
}
