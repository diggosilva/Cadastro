//
//  FeedCell.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell {
    static let identifier = "FeedCell"
    
    lazy var pokemonImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .footnote)
        label.font = .boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(pokemon: Pokemon) {
        guard let url = URL(string: pokemon.imageUrl) else { return }
        pokemonImage.sd_setImage(with: url)
        nameLabel.text = pokemon.name.capitalized
        
        self.accessoryType = UITableViewCell.AccessoryType.none
        self.accessoryType = pokemon.isFavorited ? .checkmark : .none
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
            pokemonImage.widthAnchor.constraint(equalToConstant: 70),
            pokemonImage.heightAnchor.constraint(equalTo: pokemonImage.widthAnchor),
            pokemonImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            nameLabel.centerYAnchor.constraint(equalTo: pokemonImage.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
