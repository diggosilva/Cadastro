//
//  PasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class PasswordViewController: UIViewController {
    
    private let passwordView = PasswordView()
    private let viewModel: PasswordViewModel
    
    init(cadastro: Cadastro) {
        self.viewModel = PasswordViewModel(cadastro: cadastro)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = passwordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegateAndDataSources()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.cadastro.senha != "" {
            let senha = viewModel.cadastro.senha
            passwordView.passwordTextField.text = senha
            passwordView.nextButton.isEnabled = true
            print("DEBUG: TEM DADO AQUI, a senha é \(senha)")
        } else {
            passwordView.nextButton.isEnabled = false
            print("DEBUG: NÃO TEM DADO AQUI")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setNavBar() {
        title = "Cadastrar Senha"
    }
    
    private func setDelegateAndDataSources() {
        passwordView.delegate = self
    }
}

extension PasswordViewController: PasswordViewDelegate {    
    func verificaCampoSenha() {
        if let senha = passwordView.passwordTextField.text {
            // Verifica se a senha não está vazia e atende aos critérios mínimos de segurança
            let senhaRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{4,}$"
            let senhaValida = NSPredicate(format: "SELF MATCHES %@", senhaRegex)
            passwordView.nextButton.isEnabled = senhaValida.evaluate(with: senha)
        } else {
            passwordView.nextButton.isEnabled = false
        } 
    }

    
    func didTapNextButton() {
        if let password = passwordView.passwordTextField.text {
            viewModel.enviarEmailESenhaPraProximaTela(senha: password)
            let confirmPasswordVC = ConfirmPasswordViewController(cadastro: viewModel.cadastro)
            navigationController?.pushViewController(confirmPasswordVC, animated: true)
        } else {
            print("Falha ao cadastrar Senha!")
        }
    }
}
