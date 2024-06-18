//
//  EmailViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

class EmailViewController: UIViewController {
    
    private let emailView = FormView(imageSystemName: "envelope", placeholder: "Digite seu email...")
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
        if let email = emailView.formTextField.text {
            // Remove espaços em branco no início e no fim do email
            let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Verifica se o email sem espaços em branco é válido com expressão regular
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValid = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            let isEmailValid = emailValid.evaluate(with: trimmedEmail)
            
            // Verifica se o email original é igual ao email sem espaços em branco
            let isSameEmail = email == trimmedEmail
            
            // Atualiza o estado do botão com base na validade do email
            emailView.nextButton.isEnabled = isEmailValid && isSameEmail
        } else {
            // Se não houver texto no campo de email, desabilita o botão
            emailView.nextButton.isEnabled = false
        }
    }

    func didTapNextButton() {
        if let email = emailView.formTextField.text {
            viewModel.enviarEmailPraProximaTela(email: email)
            let passwordVC = PasswordViewController(user: viewModel.user)
            navigationController?.pushViewController(passwordVC, animated: true)
        } else {
            print("Falha ao cadastrar email!")
        }
    }
    
    func jaTemConta() {
        navigationController?.popToRootViewController(animated: true)
    }
}
