import Flutter
import Foundation

class NetworkChannelHandler: NSObject, FlutterPlugin {
    private let apiClient = ApiClient()

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "com.movie.discovery/network",
            binaryMessenger: registrar.messenger()
        )
        let instance = NetworkChannelHandler()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "request":
            handleRequest(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handleRequest(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result(FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "Arguments must be a map",
                details: nil
            ))
            return
        }

        guard let baseUrl = args["baseUrl"] as? String, !baseUrl.isEmpty else {
            result(FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "baseUrl is required and cannot be empty",
                details: nil
            ))
            return
        }

        guard let path = args["path"] as? String, !path.isEmpty else {
            result(FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "path is required and cannot be empty",
                details: nil
            ))
            return
        }

        let method = args["method"] as? String ?? "GET"
        let queryParams = args["queryParams"] as? [String: Any]
        let headers = args["headers"] as? [String: String]

        apiClient.request(
            baseUrl: baseUrl,
            path: path,
            method: method,
            queryParams: queryParams,
            headers: headers
        ) { response in
            result(response)
        }
    }
}
