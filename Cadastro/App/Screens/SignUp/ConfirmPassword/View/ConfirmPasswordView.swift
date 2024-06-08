//
//  ConfirmPasswordView.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

protocol ConfirmPasswordViewDelegate: AnyObject {
    func verificaCampoConfirmarSenha()
    func didTapNextButton()
}

class ConfirmPasswordView: UIView {
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var confirmPasswordImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "lock.fill")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite novamente sua senha..."
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.becomeFirstResponder()
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
    
    weak var delegate: ConfirmPasswordViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textFieldDidChange() {
        delegate?.verificaCampoConfirmarSenha()
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
        addSubviews([logoImage, confirmPasswordImage, confirmPasswordTextField, divider1, nextButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
    
            confirmPasswordImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            confirmPasswordImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            confirmPasswordImage.widthAnchor.constraint(equalToConstant: 30),
            confirmPasswordImage.heightAnchor.constraint(equalTo: confirmPasswordImage.widthAnchor),
            
            confirmPasswordTextField.centerYAnchor.constraint(equalTo: confirmPasswordImage.centerYAnchor),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: confirmPasswordImage.trailingAnchor, constant: 10),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            divider1.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 5),
            divider1.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            nextButton.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: logoImage.widthAnchor),
        ])
    }
}
