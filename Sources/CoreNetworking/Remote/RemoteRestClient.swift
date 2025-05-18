import Foundation

public final class RemoteRestClient: RestClientType {
    private let baseURL: String
    private let session: URLSessionType

    public init(baseURL: String, session: URLSessionType = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }

    @available(macOS 12.0, iOS 13.0, *)
    public func fetch<T: Decodable>(_ endpoint: EndpointType) async throws -> T {
        guard let url = getURL(from: endpoint) else {
            throw NetworkingError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        for (key, value) in endpoint.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        do {
            let (data, _) = try await session.data(for: request, delegate: nil)
            return try parse(data)
        } catch {
            guard (error as? URLError)?.isConnectionError == true else {
                throw NetworkingError.generic
            }
            throw NetworkingError.connection
        }
    }

    private func getURL(from endpoint: EndpointType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        return components.url
    }

    private func parse<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
