import Foundation

public final class RemoteRestClient: RestClientType {
    private let baseURL: String
    private let session: URLSessionType
    private let decodingStrategy: JSONDecoder.KeyDecodingStrategy

    public init(
        baseURL: String,
        session: URLSessionType = URLSession.shared,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decodingStrategy = decodingStrategy
    }

    @available(macOS 12.0, iOS 15.0, *)
    public func fetch<T: Decodable>(_ endpoint: EndpointType) async throws -> T {
        guard let url = getURL(from: endpoint) else {
            throw NetworkingError.invalidURL
        }
        do {
            let request = getRequest(from: endpoint, url: url)
            let (data, _) = try await session.data(for: request, delegate: nil)
            return try parse(data)
        } catch is DecodingError {
            throw NetworkingError.decoding
        } catch let error as URLError where error.isConnectionError == true {
            throw NetworkingError.connection
        } catch {
            throw NetworkingError.generic
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

    private func getRequest(from endpoint: EndpointType, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        for (key, value) in endpoint.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }

    private func parse<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decodingStrategy
        return try decoder.decode(T.self, from: data)
    }
}
