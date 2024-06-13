//
//  PasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class PasswordViewController: UIViewController {
    
//    private let passwordView = PasswordView()
    private let passwordView = FormView(imageSystemName: "lock", placeholder: "Digite sua senha...", isSecureTextEntry: true)
    private let viewModel: PasswordViewModel
    
    init(user: User) {
        self.viewModel = PasswordViewModel(user: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = passwordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegateAndDataSources()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.user.senha != "" {
            let senha = viewModel.user.senha
            passwordView.formTextField.text = senha
            passwordView.nextButton.isEnabled = true
            print("DEBUG: TEM DADO AQUI, a senha é \(senha)")
        } else {
            passwordView.nextButton.isEnabled = false
            print("DEBUG: NÃO TEM DADO AQUI")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setNavBar() {
        title = "Cadastrar Senha"
    }
    
    private func setDelegateAndDataSources() {
        passwordView.delegate = self
    }
}

extension PasswordViewController: FormViewDelegate {
    func verificaCampo() {
        if let password = passwordView.formTextField.text {
            // Verifica se a senha não está vazia e atende aos critérios mínimos de segurança
            let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{4,}$"
            let passwordValid = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            passwordView.nextButton.isEnabled = passwordValid.evaluate(with: password)
        } else {
            passwordView.nextButton.isEnabled = false
        } 
    }

    
    func didTapNextButton() {
        if let password = passwordView.formTextField.text {
            viewModel.enviarEmailESenhaPraProximaTela(senha: password)
            let confirmPasswordVC = ConfirmPasswordViewController(user: viewModel.user)
            navigationController?.pushViewController(confirmPasswordVC, animated: true)
        } else {
            print("Falha ao cadastrar Senha!")
        }
    }
}
