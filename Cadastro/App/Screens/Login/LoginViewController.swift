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
        alertLoginSuccess()
    }
    
    func showErrorState() {
        alertLoginError()
    }
    
    func alertLoginSuccess() {
        let alert = UIAlertController(title: "SEJA BEM-VINDO! 🥳", message: "Aproveite nosso app!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            print("DEBUG: Entrou no app")
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func alertLoginError() {
        let alert = UIAlertController(title: "FALHA! 😥", message: "Email ou senha estão incorretos! \n Ou você não tem um cadastro!", preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Tentar novamente", style: .default) { action in
            self.loginView.emailTextField.text = ""
            self.loginView.passwordTextField.text = ""
            self.loginView.emailTextField.becomeFirstResponder()
            ShakeTextField.shakeFeedback(textField: self.loginView.emailTextField, icon: self.loginView.emailImage, divider: self.loginView.divider1)
        }
        let signUp = UIAlertAction(title: "Cadastrar agora", style: .default) { action in
            self.loginView.emailTextField.text = ""
            self.loginView.passwordTextField.text = ""
            self.naoTemConta()
        }
        alert.addAction(tryAgain)
        alert.addAction(signUp)
        present(alert, animated: true)
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
