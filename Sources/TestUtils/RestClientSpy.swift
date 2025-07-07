@testable import CoreNetworking
import Foundation

public final class RestClientSpy: RestClientType {
    public var response: Any?
    public var error: NetworkingError = .generic
    public var receivedEndpoint: EndpointType?

    public func fetch<T>(
        _ endpoint: EndpointType,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) async throws -> T where T: Decodable {
        receivedEndpoint = endpoint
        if let response = response as? T {
            return response
        }
        throw error
    }
}
