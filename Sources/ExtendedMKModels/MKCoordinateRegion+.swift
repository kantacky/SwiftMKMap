import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.center == rhs.center && lhs.span == rhs.span
    }
}
