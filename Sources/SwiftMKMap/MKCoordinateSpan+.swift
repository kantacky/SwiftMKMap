import MapKit

extension MKCoordinateSpan: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}
