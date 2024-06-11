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
    
    init(cadastro: Cadastro) {
        self.viewModel = NameViewModel(cadastro: cadastro)
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
    
    private func alertRegisteredSuccessfully() {
        let alert = UIAlertController(title: "🤗 SUCESSO!", message: "Cadastro efetuado com sucesso! \n Seja bem-vindo e aproveite nosso app!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            //TODO: após tocar no botão cadastrar, entrar no App
        }
        alert.addAction(ok)
        present(alert, animated: true)
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
        if let name = nameView.nameTextField.text {
            viewModel.enviarEmailSenhaConfirmarSenhaENomePraProximaTela(nome: name)
            alertRegisteredSuccessfully()
        } else {
            print("Falha ao cadastrar Nome!")
        }
    }
}
