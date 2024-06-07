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
        viewModel.loadData()
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
 
    }
    
    func showErrorState() {
        
    }
}

extension LoginViewController: LoginViewDelegate {
    func verificaCamposDeEmailESenha() {
        if let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text {
            loginView.loginButton.isEnabled = !email.isEmpty && !password.isEmpty
        } else {
            loginView.loginButton.isEnabled = true
        }
    }
    
    func naoTemConta() {
        let signUpEmailVC = EmailViewController()
        navigationController?.pushViewController(signUpEmailVC, animated: true)
    }
}
