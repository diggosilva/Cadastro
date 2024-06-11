//
//  ConfirmPasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {
    
    private let confirmPasswordView = ConfirmPasswordView()
    private let viewModel: ConfirmPasswordViewModel
    
    init(cadastro: Cadastro) {
        self.viewModel = ConfirmPasswordViewModel(cadastro: cadastro)
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
    
    private func alertConfirmPassword() {
        let alert = UIAlertController(title: "⛔️ Atenção!", message: "Erro ao confirmar senha! \n Sua senha deve ser a mesma digitada anteriormente.", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "Entendi", style: .default) { action in
            self.confirmPasswordView.confirmPasswordTextField.text = ""
            self.confirmPasswordView.confirmPasswordTextField.becomeFirstResponder()
            self.confirmPasswordView.nextButton.isEnabled = false
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
            confirmPasswordView.shakeFeedback(withDuration: 0.5)
            alertConfirmPassword()
        }
    }
    
    func didTapNextButton() {
        if let confirmPassword = confirmPasswordView.confirmPasswordTextField.text {
            if confirmPassword == viewModel.cadastro.senha {
                viewModel.enviarEmailSenhaEConfirmarSenhaPraProximaTela(confirmaSenha: confirmPassword)
                let nameVC = NameViewController(cadastro: viewModel.cadastro)
                navigationController?.pushViewController(nameVC, animated: true)
            } else {
                alertConfirmPassword()
                confirmPasswordView.shakeFeedback()
                print("Falha ao cadastrar Confirmação de Senha!")
            }
        }
    }
}
