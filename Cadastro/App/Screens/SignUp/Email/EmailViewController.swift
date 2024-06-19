//
//  EmailViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

class EmailViewController: UIViewController {
    
    private let emailView = FormView(imageSystemName: "envelope", placeholder: "Digite seu email...", keyboardType: .emailAddress)
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

extension EmailViewController: FormViewDelegate {
    func verificaCampo() {
        let email = emailView.formTextField.text
        let isEmailValid = viewModel.isValidEmail(email)
        emailView.nextButton.isEnabled = isEmailValid
    }
    
    func didTapNextButton() {
        guard let email = emailView.formTextField.text, viewModel.isValidEmail(email) else {
            print("Email inválido")
            return
        }
        
        viewModel.goToNextStep(email: email)
        let passwordVC = PasswordViewController(user: viewModel.user)
        navigationController?.pushViewController(passwordVC, animated: true)
    }
    
    func jaTemConta() {
        navigationController?.popToRootViewController(animated: true)
    }
}
