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
        print(server)
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
}
