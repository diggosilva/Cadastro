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
    
    init(email: String) {
        self.viewModel = PasswordViewModel(email: email)
        super.init(nibName: nil, bundle: nil)
    }
    
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
        if let password = passwordView.passwordTextField.text {
            passwordView.nextButton.isEnabled = !password.isEmpty
        } else {
            passwordView.nextButton.isEnabled = true
        }
    }
    
    func didTapNextButton() {
        if let password = passwordView.passwordTextField.text {
            viewModel.enviarEmailESenhaPraProximaTela(senha: password)
            let confirmPasswordVC = ConfirmPasswordViewController(email: viewModel.email, password: password)
            navigationController?.pushViewController(confirmPasswordVC, animated: true)
        } else {
            print("Falha ao cadastrar Senha!")
        }
    }
}
