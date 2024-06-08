//
//  ConfirmPasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {
    
    let confirmPasswordView = ConfirmPasswordView()
    let viewModel: ConfirmPasswordViewModel
    
    init(email: String, password: String) {
        self.viewModel = ConfirmPasswordViewModel(email: email, password: password)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = confirmPasswordView
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
        confirmPasswordView.delegate = self
    }
    
    func alertConfirmPassword() {
        let alert = UIAlertController(title: "⛔️ Atenção!", message: "Erro ao confirmar senha! \n Sua senha deve ser a mesma digitada anteriormente.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Entendi", style: .default) { action in
            self.confirmPasswordView.confirmPasswordTextField.text = ""
            self.confirmPasswordView.confirmPasswordTextField.becomeFirstResponder()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension ConfirmPasswordViewController: ConfirmPasswordViewDelegate {
    func verificaCampoConfirmarSenha() {
        if let confirmPassword = confirmPasswordView.confirmPasswordTextField.text {
            confirmPasswordView.nextButton.isEnabled = !confirmPassword.isEmpty
        } else {
            confirmPasswordView.nextButton.isEnabled = true
            alertConfirmPassword()
        }
    }
    
    func didTapNextButton() {
        if let confirmPassword = confirmPasswordView.confirmPasswordTextField.text {
            if confirmPassword == viewModel.password {
                viewModel.enviarEmailSenhaEConfirmarSenhaPraProximaTela(senha: viewModel.password, confirmarSenha: confirmPassword)
                let nameVC = NameViewController(email: viewModel.email, password: viewModel.password, confirmPassword: viewModel.confirmPassword)
                navigationController?.pushViewController(nameVC, animated: true)
            } else {
                alertConfirmPassword()
            }
        } else {
            print("Falha ao cadastrar Email, Senha e Confirmação de Senha!")
        }
    }
    
//    func didTapNextButton() {
//        //TODO: criar tela de Nome, e avançar quando clicar
//        if let confirmPassword = confirmPasswordView.confirmPasswordTextField.text {
//            if confirmPassword == viewModel.password {
//                viewModel.enviarEmailSenhaEConfirmarSenhaPraProximaTela(senha: viewModel.password, confirmarSenha: confirmPassword)
//                let nameVC = NameViewController(email: viewModel.email, password: viewModel.password, confirmPassword: viewModel.confirmPassword)
//                navigationController?.pushViewController(nameVC, animated: true)
//            } else {
//                print("DEBUG: Tem boi na linha, amiguinhooo!")
//            }
//        } else {
//            print("Falha ao cadastrar Email, Senha e Confirmação de Senha!")
//        }
//    }
}
