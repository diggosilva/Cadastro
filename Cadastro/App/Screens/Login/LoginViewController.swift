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
            // Validar o email usando uma expressão regular
            let emailWithoutWhiteSpaces = email.trimmingCharacters(in: .whitespaces)
            
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValid = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            
            // Verifica se a senha não está vazia e atende aos critérios mínimos de segurança
            let senhaRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{4,}$"
            let senhaValid = NSPredicate(format: "SELF MATCHES %@", senhaRegex)
            
            // Habilitar o botão de login apenas se o email e a senha forem válidos
            loginView.loginButton.isEnabled = emailValid.evaluate(with: emailWithoutWhiteSpaces) && senhaValid.evaluate(with: password)
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
