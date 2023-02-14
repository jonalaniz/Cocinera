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
    
    let signInController: SignInController

    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
        
        // Initialize our signInController
        signInController = SignInController()
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
