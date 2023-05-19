import MapKit

extension MKCoordinateRegion: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.center.hash(into: &hasher)
        self.span.hash(into: &hasher)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.center == rhs.center && lhs.span == rhs.span
    }
}
