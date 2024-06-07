//
//  SignUpPasswordView.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

protocol SignUpPasswordViewDelegate: AnyObject {
    func verificaCampoSenha()
    func didTapNextButton()
}

class SignUpPasswordView: UIView {
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
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
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var divider1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(configuration: .borderedTinted())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Próximo", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: SignUpPasswordViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textFieldDidChange() {
        delegate?.verificaCampoSenha()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapNextButton()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([logoImage, passwordImage, passwordTextField, divider1, nextButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
    
            passwordImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            passwordImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordImage.widthAnchor.constraint(equalToConstant: 30),
            passwordImage.heightAnchor.constraint(equalTo: passwordImage.widthAnchor),
            
            passwordTextField.centerYAnchor.constraint(equalTo: passwordImage.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordImage.trailingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            divider1.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            divider1.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            nextButton.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: logoImage.widthAnchor),
        ])
    }
}
