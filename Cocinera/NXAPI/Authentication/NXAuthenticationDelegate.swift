//
//  NXAuthenticationDelegate.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/19/23.
//

import Foundation

/// String descriptions for various authentication errors.
enum NXNetworkError: Int {
    case notValidHost
    case serverNotFound
    case failedToSerializeResponse
    case authorizationDataMissing

    public var description: String {
        switch self {
        case .notValidHost: return "Not valid host"
        case .serverNotFound: return "Server not found"
        case .failedToSerializeResponse: return "Vailed to Serialize Response"
        case .authorizationDataMissing: return "Data missing"
        }
    }
}

/// Functions called by ServerManager pertaining to authenitcation status
protocol NXAuthenticationDelegate: AnyObject {
    /// Called when server is successfully added to the manager
    func didCapture(server: NXServer)

    /// Called when login url and associated authorization data is recieved.
    func didRecieve(loginURL: String)

    /// Called when ServerManager is unable to get authorization data from server. Returns error information.
    func failedToGetCredentials(withError error: NXNetworkError)

    /// Called when networkManager finds network error, passes localized description.
    func networkError(error: ErrorType)
}
