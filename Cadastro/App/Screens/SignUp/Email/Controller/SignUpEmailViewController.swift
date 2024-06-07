//
//  File.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

class SignUpEmailViewController: UIViewController {
    
    let signUpEmailView = SignUpEmailView()
    let viewModel: SignUpEmailViewModel
    
    init() {
        self.viewModel = SignUpEmailViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    init(cadastro: Cadastro) {
        self.viewModel = SignUpEmailViewModel(cadastro: cadastro)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = signUpEmailView
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
        title = "Cadastrar Email"
    }
    
    private func setDelegateAndDataSources() {
        signUpEmailView.delegate = self
    }
}

extension SignUpEmailViewController: SignUpEmailViewDelegate {
    func verificaCampoEmail() {
        if let email = signUpEmailView.emailTextField.text {
            signUpEmailView.nextButton.isEnabled = !email.isEmpty
        } else {
            signUpEmailView.nextButton.isEnabled = true
        }
    }
    
    func didTapNextButton() {
        if let email = signUpEmailView.emailTextField.text {
            viewModel.enviarEmailPraProximaTela(email: email)
            let signUpPasswordVC = SignUpPasswordViewController(email: email)
            navigationController?.pushViewController(signUpPasswordVC, animated: true)
        } else {
            print("Falha ao cadastrar email!")
        }
    }
    
    func jaTemConta() {
        navigationController?.popToRootViewController(animated: true)
    }
}
