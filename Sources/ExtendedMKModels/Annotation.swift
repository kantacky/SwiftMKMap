import CoreLocation
import Foundation
import MapKit

public struct Annotation: Codable, Hashable {
    public static func == (lhs: Annotation, rhs: Annotation) -> Bool {
        lhs.coordinate == rhs.coordinate
        && lhs.title == rhs.title
        && lhs.subtitle == rhs.subtitle
    }

    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var subtitle: String?

    public var latitude: CLLocationDegrees {
        self.coordinate.latitude
    }
    public var longitude: CLLocationDegrees {
        self.coordinate.longitude
    }

    public init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

    public init(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        title: String? = nil,
        subtitle: String? = nil
    ) {
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.title = title
        self.subtitle = subtitle
    }

    public init(pointAnnotation: MKPointAnnotation) {
        self.coordinate = pointAnnotation.coordinate
        self.title = pointAnnotation.title
        self.subtitle = pointAnnotation.subtitle
    }

    public func getPointAnnotation() -> MKPointAnnotation {
        let pointAnnotation: MKPointAnnotation = .init()
        pointAnnotation.coordinate = self.coordinate
        pointAnnotation.title = self.title
        pointAnnotation.subtitle = self.subtitle
        return pointAnnotation
    }
}
