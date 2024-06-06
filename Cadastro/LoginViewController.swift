//
//  ViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        handleStates()
        viewModel.loadData()
    }
    
    private func setNavBar() {
        title = "Login"
        view.backgroundColor = .systemBackground
    }
    
    func handleStates() {
        viewModel.state.bind { states in
            switch states {
            case .loading:
                return self.showLoadingState()
            case .loaded:
                return self.showLoadedState()
            case .error:
                return self.showErrorState()
            }
        }
    }
    
    func showLoadingState() {
        
    }
    
    func showLoadedState() {
 
    }
    
    func showErrorState() {
        
    }
}
