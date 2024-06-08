//
//  EmailView.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

protocol EmailViewDelegate: AnyObject {
    func verificaCampoEmail()
    func didTapNextButton()
    func jaTemConta()
}

class EmailView: UIView {
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
        textField.autocapitalizationType = .none
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
    
    lazy var haveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Já tenho uma conta!  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.link])
        attributedTitle.append(NSAttributedString(string: "Logar!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.link]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(haveAnAccountTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: EmailViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textFieldDidChange() {
        delegate?.verificaCampoEmail()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapNextButton()
    }
    
    @objc private func haveAnAccountTapped() {
        delegate?.jaTemConta()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([logoImage, emailImage, emailTextField, divider1, nextButton, haveAnAccountButton])
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
            
            nextButton.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: logoImage.widthAnchor),
            
            haveAnAccountButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            haveAnAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
