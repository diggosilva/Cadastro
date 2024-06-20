//
//  FeedCell.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import UIKit
import SDWebImage

class FeedCell: UICollectionViewCell {
    static let identifier = "FeedCell"
    
    lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "pokeImage")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome do Pokemon"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .footnote)
        label.font = .boldSystemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(pokemon: FeedModel) {
        guard let url = URL(string: pokemon.imageUrl) else { return }
        pokemonImage.sd_setImage(with: url)
        nameLabel.text = pokemon.name
        self.backgroundColor = .systemRed.withAlphaComponent(0.25)
        self.layer.cornerRadius = 10
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        addSubviews([pokemonImage, nameLabel])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            pokemonImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pokemonImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            pokemonImage.heightAnchor.constraint(equalToConstant: 70),
            
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImage.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: pokemonImage.trailingAnchor),
        ])
    }
}
