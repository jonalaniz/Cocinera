//
//  AuthenticationController.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/8/23.
//

import UIKit

class AuthenticationViewController: UIViewController {
    weak var coordinator: AuthenicationCoordinator?
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "splash")
        
        return imageView
    }()
    
    let loginView = LoginView()
    var url: URL?

    override func loadView() {
        super.loadView()
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        arrangeViews()
    }
    
    private func arrangeViews() {
        view.backgroundColor = .black
        backgroundImageView.alpha = 0.25
        
        view.addSubview(backgroundImageView)
        view.addSubview(loginView)

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),

            loginView.widthAnchor.constraint(equalToConstant: 340),
            loginView.heightAnchor.constraint(equalToConstant: 230),
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
    }
}

extension AuthenticationViewController {
    @objc func loginButtonPressed(_ sender: Any) {
        guard
            let urlString = loginView.addressField.text,
            let url = URL(string: urlString)
        else {
            print("Enter server address")
            return
        }



        guard UIApplication.shared.canOpenURL(url) == true
        else {
            coordinator?.failedToGetCredentials(withError: .notValidHost)
            return
        }

        // Begin authorization
        coordinator?.beginAuthorization(url: url)
    }
}
