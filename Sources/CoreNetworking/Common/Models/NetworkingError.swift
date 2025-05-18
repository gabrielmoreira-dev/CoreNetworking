public enum NetworkingError: Error, Equatable {
    case generic
    case connection
    case invalidURL
    case decoding
}
