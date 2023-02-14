//
//  ViewController.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/8/23.
//

import UIKit

class LoginController: UIViewController {
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "splash")
        
        return imageView
    }()
    
    let loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 39/255, green: 40/255, blue: 43/255, alpha: 1)
        view.layer.borderColor = UIColor(red: 114/255, green: 114/255, blue: 114/255, alpha: 0.5).cgColor
        view.layer.borderWidth = 1
        view.widthAnchor.constraint(equalToConstant: 340).isActive = true
        view.heightAnchor.constraint(equalToConstant: 260).isActive = true
        
        view.layer.cornerRadius = 28
        view.clipsToBounds = true
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 40
        
        return view
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Log In", for: .normal)
        
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        arrangeViews()
    }
    
    private func arrangeViews() {
        view.backgroundColor = .black
        backgroundImageView.alpha = 0.25
        
        view.addSubview(backgroundImageView)
        view.addSubview(loginView)
        loginView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -20)
        ])
    }


}

