//
//  NXServer.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/19/23.
//

import Foundation

/// Server object used to store Nextcloud Server Authentication Credentials
struct NXServer: Codable, Equatable {
    /// Nextcloud returns the Server URL in the 'server' variable
    let server: String
    let loginName: String
    let appPassword: String
}
