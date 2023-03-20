//
//  AuthenitcationCoordinator.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/19/23.
//

import UIKit

class AuthenicationCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()

    var splitViewController: UISplitViewController
    private var navigationController = UINavigationController()
    private let authenticationViewController: AuthenticationViewController

    private let autheticator = NXAuthenticator.shared

    init(splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
        authenticationViewController = AuthenticationViewController()
        autheticator.delegate = self
    }

    func start() {
        authenticationViewController.coordinator = self
        authenticationViewController.isModalInPresentation = true
        
        navigationController.viewControllers = [authenticationViewController]
        splitViewController.present(navigationController,
                                    animated: true,
                                    completion: nil)
    }

    func openWebView(url: URL) {
        let webViewController = WebViewController()
        webViewController.coordinator = self
        webViewController.url = url

        navigationController.pushViewController(webViewController,
                                                animated: true)
    }

    func beginAuthorization(url: URL) {
        autheticator.requestAuthenitcationObject(url: url)
    }
}

extension AuthenicationCoordinator: NXAuthenticationDelegate {
    func didCapture(server: NXServer) {
        parentCoordinator?.save(server: server)
        authenticationViewController.dismiss(animated: true)
        parentCoordinator?.childDidFinish(self)
    }

    func didRecieve(loginURL: String) {
        openWebView(url: URL(string: loginURL)!)
    }

    func failedToGetCredentials(withError error: ServerManagerAuthenticationError) {
        let statusLabel = authenticationViewController.loginView.statusLabel

        switch error {
        case .notValidHost:
            statusLabel.textColor = .red
            statusLabel.text = "Invalid URL"
        case .serverNotFound:
            print("Server not found")
        case .failedToSerializeResponse:
            print("Failed to serialize response")
        case .authorizationDataMissing:
            print("Authoriation missing")
        }
    }

    func networkError(error: ErrorType) {
        print("Network Error: \(error)")
    }
}
