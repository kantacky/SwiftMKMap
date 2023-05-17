import ExtendedMKModels
import MapKit
import SwiftUI

public struct SwiftMKMapView: UIViewRepresentable {
    @Environment(\.colorScheme)
    private var colorScheme: ColorScheme
    @Binding public var region: MKCoordinateRegion?
    @Binding private var userTrackingMode: MKUserTrackingMode
    @Binding private var annotations: [Annotation]
    @Binding private var pathPoints: [CLLocationCoordinate2D]
    private let showsUserLocation: Bool
    private let showsUserTrackingButton: Bool
    private let showsCompass: Bool
    public let annotationImage: UIImage?
    public let strokeColor: UIColor?
    public let strokeWeight: CGFloat?

    public init(
        region: Binding<MKCoordinateRegion?>,
        userTrackingMode: Binding<MKUserTrackingMode>,
        annotations: Binding<[Annotation]>,
        pathPoints: Binding<[CLLocationCoordinate2D]>,
        showsUserLocation: Bool = true,
        showsUserTrackingButton: Bool = false,
        showsCompass: Bool = false,
        annotationImage: UIImage? = nil,
        strokeColor: Color? = nil,
        strokeWeight: CGFloat? = nil
    ) {
        self._region = region
        self._userTrackingMode = userTrackingMode
        self._annotations = annotations
        self._pathPoints = pathPoints
        self.showsUserLocation = showsUserLocation
        self.showsUserTrackingButton = showsUserTrackingButton
        self.showsCompass = showsCompass
        self.annotationImage = annotationImage
        if let color = strokeColor {
            self.strokeColor = UIColor(color)
        } else {
            self.strokeColor = nil
        }
        self.strokeWeight = strokeWeight
    }

    public func makeUIView(context: Context) -> MKMapView {
        self.makeView(context: context)
    }

    public func updateUIView(_ mapView: MKMapView, context: Context) {
        self.updateView(mapView: mapView, delegate: context.coordinator)
    }

    public func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }

    private func makeView(context: Context) -> MKMapView {
        let mapView: MKMapView = .init(frame: .zero)
        mapView.showsUserLocation = self.showsUserLocation
        mapView.showsCompass = self.showsCompass

        if self.showsUserTrackingButton {
            let userTrackingButton: MKUserTrackingButton = .init(mapView: mapView)
            userTrackingButton.layer.backgroundColor = UIColor(
                self.colorScheme == .dark
                ? .black
                : .white
            ).cgColor
            userTrackingButton.layer.cornerRadius = 4.0
            let bounds: CGRect = UIScreen.main.bounds
            userTrackingButton.frame = CGRect(
                x: Int(bounds.width) - 44,
                y: 128,
                width: 36,
                height: 36
            )
            mapView.addSubview(userTrackingButton)
        }

        return mapView
    }

    private func updateView(mapView: MKMapView, delegate: MKMapViewDelegate) {
        mapView.delegate = delegate

        if let region = self.region {
            mapView.setRegion(region, animated: true)
        }

        mapView.setUserTrackingMode(userTrackingMode, animated: true)

        // MARK: Annotations
        let toBeDisplayedAnnotations: [MKPointAnnotation] = Array(
            Set(self.annotations.map {
                $0.getPointAnnotation()
            })
        )
        let currentAnnotations: [MKPointAnnotation] = Array(
            Set(
                mapView.annotations.map {
                    let annotation: MKPointAnnotation = .init()
                    annotation.coordinate = $0.coordinate
                    annotation.title = $0.title as? String
                    annotation.subtitle = $0.title as? String
                    return annotation
                }
            )
        )
        let toBeAddedAnnotations: [MKPointAnnotation] = Array(
            Set(toBeDisplayedAnnotations)
                .subtracting(Set(currentAnnotations))
        )
        let toBeRemovedAnnotations: [MKPointAnnotation] = Array(
            Set(currentAnnotations)
                .subtracting(Set(toBeDisplayedAnnotations))
        )

        mapView.removeAnnotations(toBeRemovedAnnotations)
        mapView.addAnnotations(toBeAddedAnnotations)

        // MARK: Polyline
        let polyline: MKPolyline = .init(coordinates: pathPoints, count: pathPoints.count)
        mapView.addOverlay(polyline)
    }
}

public struct MapView_Previews: PreviewProvider {
    public static var previews: some View {
        SwiftMKMapView(
            region: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2DMake(0, 0),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )),
            userTrackingMode: .constant(.follow),
            annotations: .constant([]),
            pathPoints: .constant([])
        )
    }
}
