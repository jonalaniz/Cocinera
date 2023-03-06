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

    weak var delegate: NXServerManagerDelegate?

    private var server: NXServer?

    private override init() {
        super.init()
        loadSavedData()
    }

    private func loadSavedData() {
        guard
            let data = KeychainWrapper.standard.data(forKey: "AutheticatedServer"),
            let decodedServer = try? PropertyListDecoder().decode(NXServer.self,
                                                                 from: data)
        else { return }

        server = decodedServer
    }

    func save(server: NXServer) {
        do {
            KeychainWrapper.standard.set(try PropertyListEncoder().encode(server),
                                         forKey: "AuthenticatedServer")
        } catch {
            fatalError("Could not encode server data \(error)")
        }
    }

    func authenticated() -> Bool {
        return server != nil
    }
}

protocol NXServerManagerDelegate: AnyObject {

}
