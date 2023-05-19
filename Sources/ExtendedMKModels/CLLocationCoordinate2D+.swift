import CoreLocation

extension CLLocationCoordinate2D: Codable, Hashable {
    public func encode(to encoder: Encoder) throws {
        var container: UnkeyedEncodingContainer = encoder.unkeyedContainer()
        try container.encode(longitude)
        try container.encode(latitude)
    }

    public init(from decoder: Decoder) throws {
        var container: UnkeyedDecodingContainer = try decoder.unkeyedContainer()
        let longitude: CLLocationDegrees = try container.decode(CLLocationDegrees.self)
        let latitude: CLLocationDegrees = try container.decode(CLLocationDegrees.self)
        self.init(latitude: latitude, longitude: longitude)
    }

    public func hash(into hasher: inout Hasher) {
        self.latitude.hash(into: &hasher)
        self.longitude.hash(into: &hasher)
    }

    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
