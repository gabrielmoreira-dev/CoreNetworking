import Foundation
import Testing
@testable import CoreNetworking

struct RemoteRestClientTests {
    private lazy var sessionSpy: URLSessionSpy = {
        URLSessionSpy()
    }()

    private lazy var sut: RemoteRestClient = {
        RemoteRestClient(baseURL: "example.com", session: sessionSpy)
    }()

    @Test("When fetch data, should return value")
    mutating func fetchData() async throws {
        let endpoint = EndpointDummy(path: "/path")
        sessionSpy.data = "[]".data(using: .utf8)

        let result: [String] = try await sut.fetch(endpoint)

        #expect(result == [])
    }

    @Test("When fetch data, should pass correct parameters")
    mutating func fetchDataWithParameters() async throws {
        let endpoint = EndpointDummy(path: "/path",
                                     method: .get,
                                     queryItems: [URLQueryItem(name: "test", value: String(true))],
                                     headers: ["X-Test-Api": String(true)],
                                     body: String())
        sessionSpy.data = "[]".data(using: .utf8)

        let _: [String] = try await sut.fetch(endpoint)

        #expect(sessionSpy.request?.url?.absoluteString == "https://example.com/path?test=true")
        #expect(sessionSpy.request?.value(forHTTPHeaderField: "X-Test-Api") == String(true))
        #expect(sessionSpy.request?.httpBody != nil)
    }

    @Test("Fetch data with HTTP method",
          arguments: [HTTPMethod.get, .post, .put, .patch, .delete])
    mutating func fetchData(method: HTTPMethod) async throws {
        let endpoint = EndpointDummy(path: "/path", method: method)
        sessionSpy.data = "[]".data(using: .utf8)

        let _: [String] = try await sut.fetch(endpoint)

        #expect(sessionSpy.request?.httpMethod == method.rawValue)
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
        let endpoint = EndpointDummy(path: "/path")

        await #expect(throws: NetworkingError.generic) {
            let _: String = try await sut.fetch(endpoint)
        }
    }

    @Test("Fetch invalid data")
    mutating func fetchInvalidData() async throws {
        let endpoint = EndpointDummy(path: "/path")
        sessionSpy.data = Data()

        await #expect(throws: NetworkingError.decoding) {
            let _: String = try await sut.fetch(endpoint)
        }
    }
}
