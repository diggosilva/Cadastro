//
//  SignUpPasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class SignUpPasswordViewController: UIViewController {
    
    let signUpPasswordView = SignUpPasswordView()
    let viewModel: SignUpPasswordViewModel
    
    init(email: String) {
        self.viewModel = SignUpPasswordViewModel(email: email)
        super.init(nibName: nil, bundle: nil)
    }
    
    init(cadastro: Cadastro) {
        self.viewModel = SignUpPasswordViewModel(cadastro: cadastro)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = signUpPasswordView
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
        signUpPasswordView.delegate = self
    }
    
}

extension SignUpPasswordViewController: SignUpPasswordViewDelegate {
    func verificaCampoSenha() {
        if let password = signUpPasswordView.passwordTextField.text {
            signUpPasswordView.nextButton.isEnabled = !password.isEmpty
        } else {
            signUpPasswordView.nextButton.isEnabled = true
        }
    }
    
    func didTapNextButton() {
        if let password = signUpPasswordView.passwordTextField.text {
            viewModel.enviarEmailESenhaPraProximaTela(senha: password)
            let confirmPasswordVC = SignUpConfirmPasswordViewController(email: viewModel.email, password: password)
            navigationController?.pushViewController(confirmPasswordVC, animated: true)
        } else {
            print("Falha ao cadastrar Email e Senha!")
        }
    }
}
