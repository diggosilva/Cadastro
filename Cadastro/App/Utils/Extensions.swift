//
//  Extensions.swift
//  Cadastro
//
//  Created by Diggo Silva on 06/06/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({ addSubview($0.self) })
    }
}
