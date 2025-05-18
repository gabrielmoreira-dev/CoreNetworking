public protocol RestClientType {
    @available(macOS 12.0, iOS 15.0, *)
    func fetch<T: Decodable>(_ endpoint: EndpointType) async throws -> T
}
