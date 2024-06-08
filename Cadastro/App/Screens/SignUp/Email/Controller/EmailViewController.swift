//
//  EmailViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

class EmailViewController: UIViewController {
    
    private let emailView = EmailView()
    private let viewModel: EmailViewModel
    
    init() {
        self.viewModel = EmailViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    init(cadastro: Cadastro) {
        self.viewModel = EmailViewModel(cadastro: cadastro)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = emailView
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
        emailView.delegate = self
    }
}

extension EmailViewController: EmailViewDelegate {
    func verificaCampoEmail() {
        if let email = emailView.emailTextField.text {
            emailView.nextButton.isEnabled = !email.isEmpty
        } else {
            emailView.nextButton.isEnabled = true
        }
    }
    
    func didTapNextButton() {
        if let email = emailView.emailTextField.text {
            viewModel.enviarEmailPraProximaTela(email: email)
            let passwordVC = PasswordViewController(email: email)
            navigationController?.pushViewController(passwordVC, animated: true)
        } else {
            print("Falha ao cadastrar email!")
        }
    }
    
    func jaTemConta() {
        navigationController?.popToRootViewController(animated: true)
    }
}
