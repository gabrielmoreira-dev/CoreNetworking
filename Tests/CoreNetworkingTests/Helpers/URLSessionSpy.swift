import Foundation
@testable import CoreNetworking

final class URLSessionSpy: URLSessionType {
    private(set) var request: URLRequest?
    var data: Data?
    var error: Error = NetworkingError.generic

    @available(macOS 12.0, iOS 15.0, *)
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        self.request = request
        guard let data else {
            throw error
        }
        return (data, URLResponse())
    }
}
