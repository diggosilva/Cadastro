//
//  FeedViewModel.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import Foundation

protocol FeedViewModelProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> Pokemon
    func loadDataPokemon()
}

enum FeedViewControllerStates {
    case loading
    case loaded
    case error
}

class FeedViewModel: FeedViewModelProtocol {
    private (set) var state: Bindable<FeedViewControllerStates> = Bindable(value: .loading)
    private var service: ServiceProtocol = Service()
    var pokemonList: [Pokemon] = []
    var isSelected = false
    
    func numberOfRowsInSection() -> Int {
        return pokemonList.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Pokemon {
        return pokemonList[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        pokemonList[indexPath.row].isSelected.toggle()
    }
    
    func loadDataPokemon() {
        fetchRequest(url: "https://pokeapi.co/api/v2/pokemon?limit=60&offset=0")
    }
    
    func fetchRequest(url: String) {
        service.getPokemons(url: url) { pokemons in
            self.pokemonList = pokemons
            self.state.value = .loaded
        } onError: { error in
            self.state.value = .error
        }
    }
}
