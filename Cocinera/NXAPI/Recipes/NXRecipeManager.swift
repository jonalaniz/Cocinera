//
//  NXRecipeManager.swift
//  Cocinera
//
//  Created by Jon Alaniz on 3/20/23.
//

import Foundation

class NXRecipeManager: NSObject {
    ///Returns the singleton `NXRecipeManager` instance.
    public static let shared = NXRecipeManager()

    private var serverManager = NXServerManager.shared

    var recipeStubs: [Stub]?
    var categories = Set<String>()
    var keywords = Set<String>()

    private override init() {
        super.init()
        // Add more inital setup here
        decodeRecipeStubs()
    }

    func decodeRecipeStubs() {
        let path = Bundle.main.url(forResource: "stubs", withExtension: "json")!

        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: path)
            let json = try decoder.decode([Stub].self, from: data)
            recipeStubs = json
        } catch {
            print(error)
        }

        splitCategories()
        pullCategories()
        printData()
    }

    private func printData() {
        guard let stubs = recipeStubs else { return }

        for stub in stubs {
            print(stub.name)
            print(stub.recipe_id)
            print(stub.imageUrl)
            print(stub.imagePlaceholderUrl)
        }
    }

    private func splitCategories() {
        guard let stubs = recipeStubs else { return }
        let comma = CharacterSet(charactersIn: ",")

        for stub in stubs {
            if let keywordStrings = stub.keywords {
                let keywordArray = keywordStrings.components(separatedBy: comma)

                for keyword in keywordArray {
                    keywords.insert(keyword)
                }
            }
        }
    }

    private func pullCategories() {
        guard let stubs = recipeStubs else { return }

        for stub in stubs {
            if let category = stub.category {
                categories.insert(category)
            }
        }
    }

    func recipeCategories() -> [String] {
        let categoryStringArray = Array(categories)
        let sortedCategoryArray = categoryStringArray.sorted()

        return sortedCategoryArray
    }

    func recipeKeywords() -> [String] {
        let keywordStringArray = Array(keywords)
        let sortedKeywordArray = keywordStringArray.sorted()

        return sortedKeywordArray
    }

}


protocol NXRecipeManagerDelegate: AnyObject {
    /// Called when manager successfully receives a stub object
    func didRecieve(recipes: [Stub])
}
