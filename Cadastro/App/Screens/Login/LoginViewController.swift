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
            case .waitingLog:
                return self.showWaitingLogState()
            case .logged(let logUser):
                return self.showLoggedState(logUser)
            case .error:
                return self.showErrorState()
            }
        }
    }
    
    func showWaitingLogState() {
        
    }
    
    func showLoggedState(_ logUser: User) {
        let feedVM = FeedViewModel(service: Service(), user: logUser)
        let feedVC = FeedViewController(viewModel: feedVM)
        self.navigationController?.pushViewController(feedVC, animated: true)
    }
    
    func showErrorState() {
        alertLoginError()
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
            let user: User = User()
            let emailVM = EmailViewModel(user: user)
            let emailVC = EmailViewController(viewModel: emailVM)
            emailVC.emailView.formTextField.text = self.loginView.emailTextField.text
            emailVC.emailView.nextButton.isEnabled = true
            self.navigationController?.pushViewController(emailVC, animated: true)
            
            self.loginView.emailTextField.text = ""
            self.loginView.passwordTextField.text = ""
            self.loginView.loginButton.isEnabled = false
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
        let user = User()
        let emailVM = EmailViewModel(user: user)
        let emailVC = EmailViewController(viewModel: emailVM)
        navigationController?.pushViewController(emailVC, animated: true)
    }
}
