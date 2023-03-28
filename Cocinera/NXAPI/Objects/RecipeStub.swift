//
//  RecipeStub.swift
//  Cocinera
//
//  Created by Jon Alaniz on 3/20/23.
//

import Foundation

struct Stub: Codable {
    let name: String
    let keywords: String?
    let category: String?
    let dateCreated: String
    let dateModified: String
    let imageUrl: String
    let imagePlaceholderUrl: String
    let recipe_id: Int
}
