//
//  SignUpConfirmPasswordViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 07/06/24.
//

import UIKit

class SignUpConfirmPasswordViewController: UIViewController {
    
    let signUpConfirmPasswordView = SignUpConfirmPasswordView()
    let viewModel: SignUpConfirmPasswordViewModel
    
    init(email: String, password: String) {
        self.viewModel = SignUpConfirmPasswordViewModel(email: email, password: password)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = signUpConfirmPasswordView
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
//        signUpConfirmPasswordView.delegate = self
    }
}
