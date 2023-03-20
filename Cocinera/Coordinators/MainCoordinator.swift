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

    let serverManager = NXServerManager.shared
    let mainViewController = MainViewController()

    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        splitViewController.viewControllers = [mainNavigationController]
    }

    func start() {
        // Check if server needs to be authenitcated first.
        guard serverManager.authenticated() else {
            showAuthenticationView()
            return
        }

        // Here we will initalize the cookbook app once we know we are setup
    }

    private func showAuthenticationView() {
        let child = AuthenicationCoordinator(splitViewController: splitViewController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    private func showCookbook() {
        // Will add shit here
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
        }
    }

    func save(server: NXServer) {
        serverManager.save(server: server)
    }

}
