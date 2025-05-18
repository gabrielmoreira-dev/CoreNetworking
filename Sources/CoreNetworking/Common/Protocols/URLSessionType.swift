import Foundation

public protocol URLSessionType {
    @available(macOS 12.0, iOS 15.0, *)
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {}
