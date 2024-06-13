//
//  ConfirmPasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {
    
//    private let confirmPasswordView = ConfirmPasswordView()
    private let confirmPasswordView = FormView(imageSystemName: "lock.fill", placeholder: "Digite novamente sua senha...", isSecureTextEntry: true)
    private let viewModel: ConfirmPasswordViewModel
    
    init(user: User) {
        self.viewModel = ConfirmPasswordViewModel(user: user)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.user.confirmaSenha != "" {
            let confirmaSenha = viewModel.user.confirmaSenha
            confirmPasswordView.formTextField.text = confirmaSenha
            confirmPasswordView.nextButton.isEnabled = true
            print("DEBUG: TEM DADO AQUI, a senha é \(confirmaSenha)")
        } else {
            confirmPasswordView.nextButton.isEnabled = false
            print("DEBUG: NÃO TEM DADO AQUI")
        }
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
            self.confirmPasswordView.formTextField.text = ""
            self.confirmPasswordView.formTextField.becomeFirstResponder()
            self.confirmPasswordView.nextButton.isEnabled = false
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension ConfirmPasswordViewController: FormViewDelegate {
    func verificaCampo() {
        if let confirmPassword = confirmPasswordView.formTextField.text {
            // Verifica se a senha não está vazia e atende aos critérios mínimos de segurança
            let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{4,}$"
            let passwordValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            confirmPasswordView.nextButton.isEnabled = passwordValid.evaluate(with: confirmPassword)
        } else {
            confirmPasswordView.nextButton.isEnabled = true
            confirmPasswordView.shakeFeedback(withDuration: 0.5)
            alertConfirmPassword()
        }
    }
    
    func didTapNextButton() {
        if let confirmPassword = confirmPasswordView.formTextField.text {
            if confirmPassword == viewModel.user.senha {
                viewModel.enviarEmailSenhaEConfirmarSenhaPraProximaTela(confirmaSenha: confirmPassword)
                let nameVC = NameViewController(user: viewModel.user)
                navigationController?.pushViewController(nameVC, animated: true)
            } else {
                alertConfirmPassword()
                confirmPasswordView.shakeFeedback()
                print("Falha ao cadastrar Confirmação de Senha!")
            }
        }
    }
}
