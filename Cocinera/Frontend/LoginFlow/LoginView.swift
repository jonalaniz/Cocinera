//
//  LoginView.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/15/23.
//

import UIKit

class LoginView: UIView {
    let backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.clipsToBounds = true

        return view
    }()

    let backgroundViewGradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [Colors.backgroundGradientLight.cgColor, Colors.backgroundGradientDark.cgColor]

        return gradient
    }()

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo_100")
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true

        return imageView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 14

        return stackView
    }()

    let spacer = UIView()

    let addressField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .URL
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "https://www.example.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .URL
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 13
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.white

        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.white.cgColor
        textField.layer.shadowOpacity = 1
        textField.layer.shadowOffset = CGSize(width: -4, height: -4)
        textField.layer.shadowRadius = 8

        return textField
    }()

    let addressContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 13
        view.clipsToBounds = true

        view.layer.masksToBounds = false
        view.layer.shadowColor = Colors.pinkShadowColor.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 8

        return view
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "Enter your server address to get started"

        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)

        button.layer.cornerRadius = 13
        button.clipsToBounds = true

//        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: -4, height: -4)
        button.layer.shadowRadius = 8

        return button
    }()

    let loginButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 13
        view.clipsToBounds = true

        view.layer.masksToBounds = false
        view.layer.shadowColor = Colors.pinkShadowColor.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 8

        return view
    }()

    let loginButtonGradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [Colors.buttonGradientDark.cgColor, Colors.buttonGradientLight.cgColor]

        return gradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        arrangeSubLayers()
        arrangeSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        arrangeSubLayers()
        arrangeSubviews()
    }

    private func setupView() {
        clipsToBounds = true
        layer.cornerRadius = 25
        layer.masksToBounds = false
        layer.shadowColor = Colors.pinkShadowColor.cgColor
        layer.shadowOpacity = 0.40
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 10

        styleTextField(textField: addressField)
    }

    private func arrangeSubLayers() {
        backgroundView.layer.insertSublayer(backgroundViewGradientLayer, at: 0)
        loginButton.layer.insertSublayer(loginButtonGradientLayer, at: 0)
    }
    
    private func arrangeSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        spacer.translatesAutoresizingMaskIntoConstraints = false
        addressField.translatesAutoresizingMaskIntoConstraints = false
        addressContainerView.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(addressContainerView)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(loginButtonContainerView)

        addSubview(backgroundView)
        addSubview(logoImageView)
        addSubview(stackView)
        addressContainerView.addSubview(addressField)
        loginButtonContainerView.addSubview(loginButton)

        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),

            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: topAnchor),

            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

            addressField.heightAnchor.constraint(equalToConstant: 46),

            loginButton.heightAnchor.constraint(equalToConstant: 44),

            addressContainerView.topAnchor.constraint(equalTo: addressField.topAnchor),
            addressContainerView.bottomAnchor.constraint(equalTo: addressField.bottomAnchor),
            addressContainerView.leadingAnchor.constraint(equalTo: addressField.leadingAnchor),
            addressContainerView.trailingAnchor.constraint(equalTo: addressField.trailingAnchor),

            loginButtonContainerView.topAnchor.constraint(equalTo: loginButton.topAnchor),
            loginButtonContainerView.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor),
            loginButtonContainerView.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            loginButtonContainerView.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor)
        ])
    }

    private func styleTextField(textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))

        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layoutIfNeeded()

    }
}
