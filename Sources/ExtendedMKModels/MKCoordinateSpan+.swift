import MapKit

extension MKCoordinateSpan: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.latitudeDelta.hash(into: &hasher)
        self.longitudeDelta.hash(into: &hasher)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}
