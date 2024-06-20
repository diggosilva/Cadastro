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
        feedView.collectionView.delegate = self
        feedView.collectionView.dataSource = self
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
        feedView.collectionView.reloadData()
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

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        cell.configure(pokemon: viewModel.cellForRowAt(indexPath: indexPath))
        return cell
    }
}
