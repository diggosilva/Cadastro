//
//  ConfirmPasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {
    
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
            // Caso usuário tenha confirmado uma senha e volte pra mudar o email, e senha cadastrada permanecerá a mesma, lembrando, se o usuário alterar a senha no passo anterior, esse campo também deve ser alterado para a mesma senha digitada anteriormente.
        } else {
            confirmPasswordView.nextButton.isEnabled = false
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
        let confirmPassword = confirmPasswordView.formTextField.text
        let isConfirmPasswordValid = viewModel.isConfirmPasswordValid(confirmPassword)
        confirmPasswordView.nextButton.isEnabled = isConfirmPasswordValid
    }
    
    func didTapNextButton() {
        guard let confirmPassword = confirmPasswordView.formTextField.text else {
            print("Erro: Confirmação de senha não pode ser vazia.")
            return
        }
        
        if viewModel.isConfirmPasswordValid(confirmPassword) {
            viewModel.goToNextStep(confirmaSenha: confirmPassword)
            let nameVC = NameViewController(user: viewModel.user)
            navigationController?.pushViewController(nameVC, animated: true)
        } else {
            alertConfirmPassword()
            ShakeTextField.shakeFeedback(textField: confirmPasswordView.formTextField, icon: confirmPasswordView.icon, divider: confirmPasswordView.divider1)
            print("Falha ao cadastrar Confirmação de Senha!")
        }
    }
}
