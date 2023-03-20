//
//  Recipe.swift
//  Cocinera
//
//  Created by Jon Alaniz on 3/20/23.
//

import Foundation

struct Recipe: Codable {
    let name: String
    let keywords: String
    let dateCreated: String
    let dateModified: String
    let imageUrl: String
    let imagePlaceholderUrl: String?
    let id: Int
    let prepTime: String?
    let cookTime: String?
    let totalTime: String?
    let description: String
    let url: String
    let image: String
    let recipeYield: Int
    let recipeCategory: String
    let tools: [String]?
    let recipeIngredient: [String]
    let recipeInstructions: [String]
    let nutrition: NutritionInformation
}

struct NutritionInformation: Codable {
    let calories: String?
    let carbohydrateContent: String?
    let cholesterolContent: String?
    let fatContent: String?
    let fiberContent: String?
    let proteinContent: String?
    let saturatedFatContent: String?
    let servingSize: String?
    let sodiumContent: String?
    let sugarContent: String?
    let transFatContent: String?
    let unsaturateFatContent: String?
}
