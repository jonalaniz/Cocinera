//
//  MainCoordinator.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/8/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var splitViewController: UISplitViewController

    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController

        
    }

    func start() {
        // Should check firstRun

        // FirstRun = true
        // Load the 'add server' page
    }

    func showAddServerPage() {
        
    }


}
