//
//  LoginView.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func naoTemConta()
    func verificaCamposDeEmailESenha()
}

class LoginView: UIView {
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var emailImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "envelope")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu email..."
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var divider1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var passwordImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "lock")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite sua senha..."
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var divider2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(configuration: .borderedTinted())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.isEnabled = false
        return button
    }()
    
    lazy var dontHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Não tem uma conta?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.link])
        attributedTitle.append(NSAttributedString(string: "Cadastre-se!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.link]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(dontHaveAnAccountTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: LoginViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidChange() {
        delegate?.verificaCamposDeEmailESenha()
    }
    
    @objc func dontHaveAnAccountTapped() {
        delegate?.naoTemConta()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([logoImage, emailImage, emailTextField, divider1, passwordImage, passwordTextField, divider2, loginButton, dontHaveAnAccountButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
    
            emailImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            emailImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailImage.widthAnchor.constraint(equalToConstant: 30),
            emailImage.heightAnchor.constraint(equalTo: emailImage.widthAnchor),
            
            emailTextField.centerYAnchor.constraint(equalTo: emailImage.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailImage.trailingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            divider1.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            divider1.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            passwordImage.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 20),
            passwordImage.leadingAnchor.constraint(equalTo: emailImage.leadingAnchor),
            passwordImage.widthAnchor.constraint(equalTo: emailImage.widthAnchor),
            passwordImage.heightAnchor.constraint(equalTo: emailImage.widthAnchor),
            
            passwordTextField.centerYAnchor.constraint(equalTo: passwordImage.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            divider2.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            divider2.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            
            loginButton.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: logoImage.widthAnchor),
            
            dontHaveAnAccountButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            dontHaveAnAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
