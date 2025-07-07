import Testing
import CoreNetworking
@testable import CoreNetworkingTestUtils

struct RestClientSpyTests {
    private let endpoint = EndpointDummy()

    @Test("Fetch data")
    func fetchData() async throws {
        let sut = RestClientSpy()
        sut.response = String()

        let _: String = try await sut.fetch(endpoint)

        #expect(sut.receivedEndpoint as? EndpointDummy == endpoint)
    }

    @Test("Fetch data with success result")
    func fetchDataWithSuccess() async throws {
        let sut = RestClientSpy()
        let expectedResponse = "Test"
        sut.response = expectedResponse

        let response: String = try await sut.fetch(endpoint)

        #expect(response == expectedResponse)
    }

    @Test("Fetch data with error result")
    func fetchDataWithFailure() async throws {
        let sut = RestClientSpy()

        await #expect(throws: NetworkingError.generic) {
            let _: String = try await sut.fetch(endpoint)
        }
    }
}
