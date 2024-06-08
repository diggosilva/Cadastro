//
//  NameViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import UIKit

class NameViewController: UIViewController {
    
    private let nameView = NameView()
    private let viewModel: NameViewModel
    
    init(email: String, password: String, confirmPassword: String) {
        self.viewModel = NameViewModel(email: email, password: password, confirmPassword: confirmPassword)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = nameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegateAndDataSources()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setNavBar() {
        title = "Digite seu nome"
    }
    
    private func setDelegateAndDataSources() {
        nameView.delegate = self
    }
}

extension NameViewController: NameViewDelegate {
    func verificaCampoNome() {
        if let name = nameView.nameTextField.text {
            nameView.signUpButton.isEnabled = !name.isEmpty
        } else {
            nameView.signUpButton.isEnabled = true
        }
    }
    
    func didTapSignUpButton() {
        //TODO: após tocar no botão cadastrar, avançar entrar no App
        if let name = nameView.nameTextField.text {
            print("DEBUG: \(Cadastro(email: viewModel.email, senha: viewModel.password, confirmaSenha: viewModel.confirmPassword, nome: name))")
            print("DEBUG: CADASTRADO COM SUCESSO!")
        }
    }
}
