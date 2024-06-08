//
//  NameView.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import UIKit

protocol NameViewDelegate: AnyObject {
    func verificaCampoNome()
    func didTapSignUpButton()
}

class NameView: UIView {
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "pencil.and.list.clipboard")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu nome..."
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .words
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
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(configuration: .borderedTinted())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: NameViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textFieldDidChange() {
        delegate?.verificaCampoNome()
    }
    
    @objc private func signUpButtonTapped() {
        delegate?.didTapSignUpButton()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([logoImage, nameImage, nameTextField, divider1, signUpButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
    
            nameImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            nameImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameImage.widthAnchor.constraint(equalToConstant: 30),
            nameImage.heightAnchor.constraint(equalTo: nameImage.widthAnchor),
            
            nameTextField.centerYAnchor.constraint(equalTo: nameImage.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            divider1.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            divider1.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            signUpButton.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 40),
            signUpButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: logoImage.widthAnchor),
        ])
    }
}
