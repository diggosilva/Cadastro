//
//  SignUpConfirmPasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class SignUpConfirmPasswordViewController: UIViewController {
    
    let signUpConfirmPasswordView = SignUpConfirmPasswordView()
    let viewModel: SignUpConfirmPasswordViewModel
    
    init(email: String, password: String) {
        self.viewModel = SignUpConfirmPasswordViewModel(email: email, password: password)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = signUpConfirmPasswordView
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
        title = "Confirmar Senha"
    }
    
    private func setDelegateAndDataSources() {
        signUpConfirmPasswordView.delegate = self
    }
    
    func alertConfirmPassword() {
        let alert = UIAlertController(title: "⚠️ Atenção!", message: "Erro ao confirmar senha: Sua senha deve ser a mesma que você digitou anteriormente", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Entendi", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension SignUpConfirmPasswordViewController: SignUpConfirmPasswordViewDelegate {
    func verificaCampoConfirmarSenha() {
        if let confirmPassword = signUpConfirmPasswordView.confirmPasswordTextField.text {
            signUpConfirmPasswordView.nextButton.isEnabled = !confirmPassword.isEmpty
        } else {
            signUpConfirmPasswordView.nextButton.isEnabled = true
            alertConfirmPassword()
        }
    }
    
    func didTapNextButton() {
        //TODO: criar tela de Nome, e avançar quando clicar
        if let confirmPassword = signUpConfirmPasswordView.confirmPasswordTextField.text {
            viewModel.enviarEmailSenhaEConfirmarSenhaPraProximaTela(senha: viewModel.password, confirmarSenha: confirmPassword)
        } else {
            print("Falha ao cadastrar Email, Senha e Confirmação de Senha!")
        }
    }
}
