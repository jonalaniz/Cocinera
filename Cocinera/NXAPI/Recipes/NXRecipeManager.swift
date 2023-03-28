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

    private override init() {
        super.init()
        // Add more inital setup here
    }

    
}
