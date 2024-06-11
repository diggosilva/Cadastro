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
    
    init(viewModel: EmailViewModel) {
        self.viewModel = viewModel
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
            let emailWithoutWhiteSpaces = email.trimmingCharacters(in: .whitespaces)
            
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValid = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            
            emailView.nextButton.isEnabled = emailValid.evaluate(with: emailWithoutWhiteSpaces)
        } else {
            emailView.nextButton.isEnabled = false
        }
    }

    func didTapNextButton() {
        if let email = emailView.emailTextField.text {
            viewModel.enviarEmailPraProximaTela(email: email)
            let passwordVC = PasswordViewController(cadastro: viewModel.cadastro)
            navigationController?.pushViewController(passwordVC, animated: true)
        } else {
            print("Falha ao cadastrar email!")
        }
    }
    
    func jaTemConta() {
        navigationController?.popToRootViewController(animated: true)
    }
}
