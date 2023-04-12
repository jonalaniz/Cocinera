//
//  NXServerManager.swift
//  Cocinera
//
//  Created by Jon Alaniz on 3/3/23.
//

import Foundation

/// Facilitates the creation, deletion, and storage of server data
class NXServerManager: NSObject {
    /// Returns the singleton `NXServerManager` instance.
    public static let shared = NXServerManager()
    private var server: NXServer?

    private override init() {
        super.init()
        loadSavedData()
    }

    private func loadSavedData() {
        guard
            let data = KeychainWrapper.standard.data(forKey: ServerKeyString),
            let decodedServer = try? PropertyListDecoder().decode(NXServer.self,
                                                                 from: data)
        else { return }

        server = decodedServer
    }

    func save(server: NXServer) {
        do {
            KeychainWrapper.standard.set(try PropertyListEncoder().encode(server),
                                         forKey: ServerKeyString)
        } catch {
            fatalError("Could not encode server data \(error)")
        }
    }

    func clearSaveData() {
        do {
            KeychainWrapper.standard.removeObject(forKey: ServerKeyString)
        }
    }

    func authenticated() -> Bool {
        return server != nil
    }
    
    func deauthorize(server: NXServer) async throws {
        // Create the URL components and append correct path
        var components = URLComponents(string: server.server)!
        components.path += Endpoints.appPassword.rawValue

        // Configure headers
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers()

        // Configure HTTP Request
        var request = URLRequest(url: components.url!)
        request.httpMethod = "DELETE"

        let session = URLSession(configuration: config)

        let (_, _) = try await session.data(for: request)
    }
    
    func headers() -> [String: String]? {
        guard
            let loginName = server?.loginName,
            let appPassword = server?.appPassword
        else { return nil }
        
        let credentials = "\(loginName):\(appPassword)"
        let credentialData = credentials.data(using: .utf8)!
        let base64Credentials = credentialData.base64EncodedString()
        let headers = ["Authorization": base64Credentials,
                       "OCS-APIREQUEST": "true",
                       "Accept": "application/json"]

        return headers
    }
}
