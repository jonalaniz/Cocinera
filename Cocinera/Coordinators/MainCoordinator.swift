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
    
    let signInController: LoginController

    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
        
        // Initialize our signInController
        signInController = LoginController()
    }

    func start() {
        // Should check firstRun

        // FirstRun = true
        // Load the 'add server' page
        splitViewController.viewControllers = [signInController]
    }

    func showAddServerPage() {
        
    }


}
