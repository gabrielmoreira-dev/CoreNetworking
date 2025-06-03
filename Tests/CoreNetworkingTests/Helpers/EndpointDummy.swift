import Foundation
@testable import CoreNetworking

struct EndpointDummy: EndpointType {
    let baseURL: String
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]
    let headers: [String: String]
    let body: Encodable?

    init(baseURL: String = "example.com",
         path: String = "/path",
         method: HTTPMethod = .get,
         queryItems: [URLQueryItem] = [],
         headers: [String: String] = [:],
         body: Encodable? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
        self.body = body
    }
}
