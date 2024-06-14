//
//  ViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let viewModel = LoginViewModel()
    
    override func loadView() {
        super.loadView()
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegateAndDataSources()
        handleStates()
//        viewModel.loginUser()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setNavBar() {
        title = "Login"
    }
    
    private func setDelegateAndDataSources() {
        loginView.delegate = self
    }
    
    func handleStates() {
        viewModel.state.bind { states in
            switch states {
            case .loading:
                return self.showLoadingState()
            case .loaded:
                return self.showLoadedState()
            case .error:
                return self.showErrorState()
            }
        }
    }
    
    func showLoadingState() {
        
    }
    
    func showLoadedState() {
        print("DEBUG: SUCESSO! 🥳")
    }
    
    func showErrorState() {
        print("DEBUG: FALHA! 😥")
    }
}

extension LoginViewController: LoginViewDelegate {
    func didTapLoginButton() {
        viewModel.loginUser()
    }
    
    func verificaCamposDeEmailESenha() {
        if let email = loginView.emailTextField.text, !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
           let password = loginView.passwordTextField.text, !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            viewModel.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.password = password.trimmingCharacters(in: .whitespacesAndNewlines)
            loginView.loginButton.isEnabled = true
        } else {
            loginView.loginButton.isEnabled = false
        }
    }

    
    func naoTemConta() {
        let emailVM = EmailViewModel()
        let emailVC = EmailViewController(viewModel: emailVM)
        navigationController?.pushViewController(emailVC, animated: true)
    }
}
