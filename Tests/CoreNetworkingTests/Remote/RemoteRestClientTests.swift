import Foundation
import Testing
@testable import CoreNetworking

struct RemoteRestClientTests {
    private lazy var sessionSpy: URLSessionSpy = {
        URLSessionSpy()
    }()

    private lazy var sut: RemoteRestClient = {
        RemoteRestClient(session: sessionSpy)
    }()

    @Test("Fetch data")
    mutating func fetchData() async throws {
        let endpoint = EndpointDummy()
        sessionSpy.data = Data("[]".utf8)

        let result: [String] = try await sut.fetch(endpoint)

        #expect(result == [])
    }

    @Test("Fetch data with parameters")
    mutating func fetchDataWithParameters() async throws {
        let endpoint = EndpointDummy(
            baseURL: "example.com",
            path: "/path",
            method: .post,
            queryItems: [URLQueryItem(name: "test", value: String(true))],
            headers: ["X-Test-Api": String(true)],
            body: String()
        )
        sessionSpy.data = Data("[]".utf8)

        let _: [String] = try await sut.fetch(endpoint)

        #expect(sessionSpy.request?.httpMethod == HTTPMethod.post.rawValue)
        #expect(sessionSpy.request?.url?.absoluteString == "https://example.com/path?test=true")
        #expect(sessionSpy.request?.value(forHTTPHeaderField: "X-Test-Api") == String(true))
        #expect(sessionSpy.request?.httpBody != nil)
    }

    @Test("Fetch data with default parameters")
    mutating func fetchDataWithDefaultParameters() async throws {
        struct DefaultEndpoint: EndpointType {
            var baseURL: String { "example.com" }
            var path: String { "/path" }
        }
        let endpoint = DefaultEndpoint()
        sessionSpy.data = Data("[]".utf8)

        let _: [String] = try await sut.fetch(endpoint)

        #expect(sessionSpy.request?.httpMethod == HTTPMethod.get.rawValue)
        #expect(sessionSpy.request?.url?.absoluteString == "https://example.com/path?")
        #expect(sessionSpy.request?.httpBody == nil)
    }

    @Test("Fetch data with HTTP method",
          arguments: [HTTPMethod.get, .post, .put, .patch, .delete])
    mutating func fetchData(method: HTTPMethod) async throws {
        let endpoint = EndpointDummy(method: method)
        sessionSpy.data = Data("[]".utf8)

        let _: [String] = try await sut.fetch(endpoint)

        #expect(sessionSpy.request?.httpMethod == method.rawValue)
    }

    @Test("Fetch data using snake case decoding strategy")
    mutating func fetchDataWithDecodingStrategy() async throws {
        struct Response: Decodable {
            let textValue: String
        }
        let endpoint = EndpointDummy()
        let expectedValue = "Value"
        sessionSpy.data = Data("{\"text_value\": \"\(expectedValue)\"}".utf8)

        let response: Response = try await sut.fetch(endpoint, decodingStrategy: .convertFromSnakeCase)

        #expect(response.textValue == expectedValue)
    }

    @Test("Fetch data with invalid URL")
    mutating func fetchWithInvalidURL() async throws {
        let endpoint = EndpointDummy(path: "Invalid path")

        await #expect(throws: NetworkingError.invalidURL) {
            let _: String = try await sut.fetch(endpoint)
        }
    }

    @Test("Generic server error")
    mutating func fetchWithGenericError() async throws {
        let endpoint = EndpointDummy()

        await #expect(throws: NetworkingError.generic) {
            let _: String = try await sut.fetch(endpoint)
        }
    }

    @Test("Internet error")
    mutating func fetchWithInternetError() async throws {
        let endpoint = EndpointDummy()
        sessionSpy.error = URLError(.networkConnectionLost)

        await #expect(throws: NetworkingError.connection) {
            let _: String = try await sut.fetch(endpoint)
        }
    }

    @Test("Fetch invalid data")
    mutating func fetchInvalidData() async throws {
        let endpoint = EndpointDummy()
        sessionSpy.data = Data()

        await #expect(throws: NetworkingError.decoding) {
            let _: String = try await sut.fetch(endpoint)
        }
    }
}
