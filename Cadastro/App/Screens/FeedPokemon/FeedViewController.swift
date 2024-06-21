//
//  FeedViewController.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let feedView = FeedView()
    private let viewModel = FeedViewModel()
    
    override func loadView() {
        super.loadView()
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegatesAndDataSources()
        handleStates()
        viewModel.loadDataPokemon()
    }
    
    private func setNavBar() {
        title = "Pokemons"
    }
    
    private func setDelegatesAndDataSources() {
        feedView.tableView.delegate = self
        feedView.tableView.dataSource = self
    }
    
    private func handleStates() {
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
    
    private func showLoadingState() {
        feedView.removeFromSuperview()
    }
    
    private func showLoadedState() {
        feedView.spinner.stopAnimating()
        feedView.tableView.reloadData()
    }
    
    private func showErrorState() {
        let alert = UIAlertController(title: "Opa, ocorreu um erro!", message: "Tentar novamente?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Sim", style: .default) { action in
            self.viewModel.loadDataPokemon()
        }
        let nok = UIAlertAction(title: "Não", style: .cancel) { action in
            self.feedView.spinner.stopAnimating()
            self.feedView.errorLabel.isHidden = false
        }
        alert.addAction(ok)
        alert.addAction(nok)
        present(alert, animated: true)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UITableViewCell() }
        cell.configure(pokemon: viewModel.cellForRowAt(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.cellForRowAt(indexPath: indexPath)
        viewModel.didSelectRowAt(indexPath: indexPath)
        tableView.reloadData()
    }
}
