//
//  FormView.swift
//  Cadastro
//
//  Created by Diggo Silva on 13/06/24.
//

import UIKit

@objc protocol FormViewDelegate: AnyObject {
    func verificaCampo()
    func didTapNextButton()
    @objc optional func jaTemConta()
}

class FormView: UIView {
    
    private let imageSystemName: String
    private let placeholder: String
    private var isSecureTextEntry: Bool?
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: imageSystemName)?.withTintColor(.label, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var formTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.becomeFirstResponder()
        textField.isSecureTextEntry = isSecureTextEntry ?? false
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
    
    weak var delegate: FormViewDelegate?
    
    init(imageSystemName: String, placeholder: String, showHasAccountButton: Bool = false, isSecureTextEntry: Bool? = false) {
        self.imageSystemName = imageSystemName
        self.placeholder = placeholder
        super.init(frame: .zero)
        self.haveAnAccountButton.isHidden = !showHasAccountButton
        self.isSecureTextEntry = isSecureTextEntry
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shakeFeedback(withDuration: CGFloat = 0.05) {
        UIView.animate(withDuration: withDuration, animations: {
            self.formTextField.transform = CGAffineTransform(translationX: 10, y: 0)
            self.icon.transform = CGAffineTransform(translationX: 10, y: 0)
        }, completion: { _ in
            UIView.animate(withDuration: withDuration, animations: {
                self.formTextField.transform = CGAffineTransform(translationX: -10, y: 0)
                self.icon.transform = CGAffineTransform(translationX: -10, y: 0)
            }, completion: { _ in
                UIView.animate(withDuration: withDuration, animations: {
                    self.formTextField.transform = CGAffineTransform(translationX: 5, y: 0)
                    self.icon.transform = CGAffineTransform(translationX: 5, y: 0)
                }, completion: { _ in
                    UIView.animate(withDuration: withDuration, animations: {
                        self.formTextField.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.icon.transform = CGAffineTransform(translationX: 0, y: 0)
                    })
                })
            })
        })
    }
    
    @objc private func textFieldDidChange() {
        delegate?.verificaCampo()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.didTapNextButton()
    }
    
    @objc private func haveAnAccountTapped() {
        delegate?.jaTemConta?()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([logoImage, icon, formTextField, divider1, nextButton, haveAnAccountButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor),
    
            icon.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            icon.widthAnchor.constraint(equalToConstant: 30),
            icon.heightAnchor.constraint(equalTo: icon.widthAnchor),
            
            formTextField.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            formTextField.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            formTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            divider1.topAnchor.constraint(equalTo: formTextField.bottomAnchor, constant: 5),
            divider1.leadingAnchor.constraint(equalTo: formTextField.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: formTextField.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            nextButton.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 40),
            nextButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: logoImage.widthAnchor),
            
            haveAnAccountButton.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor),
            haveAnAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}
