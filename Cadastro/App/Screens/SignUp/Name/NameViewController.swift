//
//  NameViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import UIKit

class NameViewController: UIViewController {
    
    private let nameView = FormView(imageSystemName: "pencil.and.list.clipboard", placeholder: "Digite seu nome...", autocapitalizationType: .words)
    private let viewModel: NameViewModel
    
    init(user: User) {
        self.viewModel = NameViewModel(user: user)
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
    
    private func alertRegisteredFailure() {
        let alert = UIAlertController(title: "✋🏻 FALHA!", message: "Erro ao cadastrar email! \n Esse email já está sendo utilizado", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            print("DEBUG: Cadastre novo email.")
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension NameViewController: FormViewDelegate {
    func verificaCampo() {
        if let name = nameView.formTextField.text {
            let nameRegex = "^[a-zA-Z]+( [a-zA-Z]+)*$" // Expressão regular para verificar letras e espaços apenas entre palavras
            let nameValid = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            nameView.nextButton.isEnabled = nameValid.evaluate(with: name)
        } else {
            nameView.nextButton.isEnabled = false
        }
    }
    
    func didTapNextButton() {
        if let name = nameView.formTextField.text {
            viewModel.enviarEmailSenhaConfirmarSenhaENomePraProximaTela(nome: name)
            alertRegisteredSuccessfully()
        } else {
            alertRegisteredFailure()
            print("Falha ao cadastrar Nome!")
        }
    }
}
