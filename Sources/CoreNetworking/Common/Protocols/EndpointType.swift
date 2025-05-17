import Foundation

protocol EndpointType {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String: String] { get }
}

extension EndpointType {
    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem] {
        []
    }

    var headers: [String: String] {
        [:]
    }
}
