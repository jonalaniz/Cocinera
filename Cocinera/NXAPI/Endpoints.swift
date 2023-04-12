//
//  Endpoints.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/19/23.
//

import Foundation

enum Endpoints: String {
    // Authentication Endpoints
    case appPassword = "/ocs/v2.php/core/apppassword"
    case loginEndpoint = "/index.php/login/v2"
    case logoEndpoint = "/index.php/apps/theming/image/logo"

    // Nextcloud Cookbook specific Endpoints
    case allRecipes = "/index.php/apps/cookbook/api/v1/recipes"
}
