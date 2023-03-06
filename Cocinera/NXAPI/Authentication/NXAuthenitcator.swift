//
//  AuthenitcationManager.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/19/23.
//

import Foundation

/// Facilitates the authentication and capturing of server objects.
class NXAuthenticator: NSObject {
    /// Returns the singleton `NXAuthenitcationManager` instance.
    public static let shared = NXAuthenticator()

    weak var delegate: NXAuthenticationDelegate?

    private let dataManager = DataManager.shared
    private var shouldPoll = false

    func requestAuthenitcationObject(url: URL) {
        Task {
            do {
                let object = try await dataManager.fetchAuthenticationData(url: url)

                // Begin authenitcaion using recieved object
                setupAuthenitcationObject(with: object)
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }

    private func setupAuthenitcationObject(with object: AuthenticationObject) {
        // Check for data from authenticationObject
        guard
            let pollURL = URL(string: (object.poll?.endpoint)!),
            let token = object.poll?.token,
            let loginURL = object.login
        else {
            delegate?.failedToGetCredentials(withError: .authorizationDataMissing)
            return
        }

        // Notify our delegate of loginURL and begin polling and grab custom image
        DispatchQueue.main.async {
            self.delegate?.didRecieve(loginURL: loginURL)
        }

        shouldPoll = true

        poll(at: pollURL, with: token)
    }

    private func poll(at url: URL, with token: String) {
        Task {
            do {
                let server = try await dataManager.pollForServerData(at: url, with: token)
                shouldPoll = false
                DispatchQueue.main.async {
                    self.delegate?.didCapture(server: server)
                }
            } catch {
                guard let fetchError = error as? ErrorType else {
                    DispatchQueue.main.async {
                        self.delegate?.networkError(error: .error(error.localizedDescription))
                    }
                    return
                }

                DispatchQueue.main.async {
                    switch fetchError {
                    case .invalidURL:
                        self.delegate?.networkError(error: .invalidURL)
                    case .error(let err):
                        self.delegate?.networkError(error: .error(err))
                    case .missingResponse:
                        self.delegate?.networkError(error: .missingResponse)
                    case .unexpectedResponse(let response):
                        if response.statusCode == 404 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.poll(at: url, with: token)
                            }
                        }
                        self.delegate?.networkError(error: .unexpectedResponse(response))
                    case .invalidData:
                        self.delegate?.networkError(error: .invalidData)
                    }
                }
            }
        }
    }

    /// Sends an HTTP DELETE request to specificed server, clearing app specific password
    /// and deauthorizing NextStats
    // TODO: Add completion handler to return an error if one is found,
    // Error should be generic and handler will just ask user to check
    // their server to remove the app password manually.
    static func deauthorize(server: NXServer) async throws {
        // Create the URL components and append correct path
        var components = URLComponents(string: server.server)!
        components.path += Endpoints.appPassword.rawValue

        // Configure headers
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = DataManager.headers(for: server)

        // Configure HTTP Request
        var request = URLRequest(url: components.url!)
        request.httpMethod = "DELETE"

        let session = URLSession(configuration: config)

        let (_, _) = try await session.data(for: request)
    }
}

// MARK: Helper Functions
extension NXAuthenticator {
    func cancelAuthorization() {
        shouldPoll = false
    }

    private func decode<T: Decodable>(modelType: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        guard let object = try? decoder.decode(modelType, from: data) else { return nil }

        return object
    }
}
