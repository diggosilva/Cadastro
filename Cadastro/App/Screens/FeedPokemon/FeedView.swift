//
//  FeedView.swift
//  Cadastro
//
//  Created by Diggo Silva on 20/06/24.
//

import UIKit

class FeedView: UIView {
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
        tableView.backgroundColor = .secondarySystemBackground
        return tableView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.text = "Tente novamente mais tarde!"
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .systemBackground
        addSubviews([tableView, spinner, errorLabel])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: spinner.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
