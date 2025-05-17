import Foundation

extension URLError {
    var isConnectionError: Bool {
        let codes = [
            NSURLErrorBadURL,
            NSURLErrorTimedOut,
            NSURLErrorCannotFindHost,
            NSURLErrorCannotConnectToHost,
            NSURLErrorNetworkConnectionLost,
            NSURLErrorNotConnectedToInternet
        ]
        return codes.contains(code.rawValue)
    }
}
