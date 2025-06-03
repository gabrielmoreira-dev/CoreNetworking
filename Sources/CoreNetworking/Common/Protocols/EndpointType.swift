import Foundation

public protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
}

public extension EndpointType {
    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem] { [] }

    var headers: [String: String] { [:] }

    var body: Encodable? { nil }
}
