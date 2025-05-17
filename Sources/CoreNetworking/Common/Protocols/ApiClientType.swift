protocol ApiClientType {
    func fetchData<T: Decodable>(from endpoint: EndpointType) async throws -> T
}
