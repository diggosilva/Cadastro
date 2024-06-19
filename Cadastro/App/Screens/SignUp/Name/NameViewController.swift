//
//  NameViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 08/06/24.
//

import UIKit

class NameViewController: UIViewController {
    
    private let nameView = FormView(imageSystemName: "pencil.and.list.clipboard", placeholder: "Digite seu nome...", autocapitalizationType: .words, setTitle: "Finalizar Cadastro")
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
        verificaCampo()
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
        let alert = UIAlertController(title: "🤗 SUCESSO!", message: "Cadastro efetuado com sucesso! \n Faça o login!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    private func alertRegisteredFailure() {
        let alert = UIAlertController(title: "✋🏻 FALHA!", message: "Erro ao cadastrar email! \n Esse email já está sendo utilizado", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            print("DEBUG: Tente usar outro email.")
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension NameViewController: FormViewDelegate {
    func verificaCampo() {
        guard let nome = nameView.formTextField.text else {
            nameView.nextButton.isEnabled = false
            return
        }
        
        let nomeValido = viewModel.validarNome(nome: nome)
        nameView.nextButton.isEnabled = nomeValido
    }
    
    func didTapNextButton() {
        guard let name = nameView.formTextField.text else {
            alertRegisteredFailure()
            print("Falha ao cadastrar nome")
            return
        }
        viewModel.salvarDadosDoUsuario(nome: name) { [weak self] success in
            if success {
                self?.alertRegisteredSuccessfully()
            } else {
                self?.alertRegisteredFailure()
            }
        }
    }
}
