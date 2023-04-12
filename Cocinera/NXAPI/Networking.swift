//
//  Networking.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/19/23.
//

import Foundation

enum ErrorType: Error {
    case invalidURL
    // This error being sent should be Error.loaclized description
    case error(String)
    case missingResponse
    case unexpectedResponse(HTTPURLResponse)
    case invalidData
}

/// DataManager struct manages networking calls
class DataManager {
    /// Returns the singleton `DataManager` instance
    public static let shared = DataManager()

    private init() { }

    func fetchAuthenticationData(url: URL) async throws -> AuthenticationObject {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.path += Endpoints.loginEndpoint.rawValue

        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.setUserAgent()

        let config = config()
        let session = URLSession(configuration: config)

        let (data, response) = try await session.data(for: request)

        guard let urlResponse = response as? HTTPURLResponse else {
            throw ErrorType.missingResponse
        }

        guard urlResponse.statusCode == 200 else {
            throw ErrorType.unexpectedResponse(urlResponse)
        }

        guard let object = try? JSONDecoder().decode(AuthenticationObject.self,
                                                     from: data) else {
            throw ErrorType.invalidData
        }

        return object
    }

    func pollForServerData(at url: URL, with token: String) async throws -> NXServer {
        let tokenPrefix = "token="
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = (tokenPrefix + token).data(using: .utf8)
        request.setUserAgent()

        let config = config()
        let session = URLSession(configuration: config)

        let (data, response) = try await session.data(for: request)

        guard let urlResponse = response as? HTTPURLResponse else {
            throw ErrorType.missingResponse
        }

        guard urlResponse.statusCode == 200 else {
            throw ErrorType.unexpectedResponse(urlResponse)
        }

        guard let server = try? JSONDecoder().decode(NXServer.self, from: data) else {
            throw ErrorType.invalidData
        }

        return server
    }

    func config() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 30
        config.httpMaximumConnectionsPerHost = 1

        return config
    }
}

extension URLRequest {
    mutating func setUserAgent() {
        self.setValue("Cocinera for Nextcloud Cookbook", forHTTPHeaderField: "User-Agent")
    }
}
