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
        view.backgroundColor = Colors.backgroundColor
        view.layer.cornerRadius = 23
        view.clipsToBounds = true

        return view
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 13
        textField.clipsToBounds = true
        textField.layer.borderColor = Colors.borderColor.cgColor
        textField.backgroundColor = Colors.backgroundColor
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 46).isActive = true

        return textField
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .caption1)
        label.text = "Enter your server address to get started"

        return label
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.cocineraGreen
        button.setTitle("Log In", for: .normal)

        button.layer.cornerRadius = 13
        button.clipsToBounds = true

        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        arrangeSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        arrangeSubviews()
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.borderColor

        layer.cornerRadius = 25
        clipsToBounds = true

        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 40

        styleTextField(textField: addressField)
    }
    
    private func arrangeSubviews() {
        spacer.translatesAutoresizingMaskIntoConstraints = false
        addressField.translatesAutoresizingMaskIntoConstraints = false
        addressField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(addressField)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(loginButton)

        addSubview(backgroundView)
        addSubview(logoImageView)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor, constant: -4),
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor, constant: -4),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),

            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: topAnchor),

            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)

        ])
    }

    private func styleTextField(textField: UITextField) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))

        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layoutIfNeeded()

    }
}
