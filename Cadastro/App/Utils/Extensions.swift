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

class ShakeTextField {
    // Método para animar feedback (Ex: Senha incorreta ou Campo vazio)
    static func shakeFeedback(withDuration: CGFloat = 0.05, textField: UITextField, icon: UIImageView?, divider: UIView? = nil) {
        UIView.animate(withDuration: withDuration, animations: {
            textField.transform = CGAffineTransform(translationX: 10, y: 0)
            icon?.transform = CGAffineTransform(translationX: 10, y: 0)
            divider?.transform = CGAffineTransform(translationX: 10, y: 0)
        }, completion: { _ in
            UIView.animate(withDuration: withDuration, animations: {
                textField.transform = CGAffineTransform(translationX: -10, y: 0)
                icon?.transform = CGAffineTransform(translationX: -10, y: 0)
                divider?.transform = CGAffineTransform(translationX: -10, y: 0)
            }, completion: { _ in
                UIView.animate(withDuration: withDuration, animations: {
                    textField.transform = CGAffineTransform(translationX: 5, y: 0)
                    icon?.transform = CGAffineTransform(translationX: 5, y: 0)
                    divider?.transform = CGAffineTransform(translationX: 5, y: 0)
                }, completion: { _ in
                    UIView.animate(withDuration: withDuration, animations: {
                        textField.transform = CGAffineTransform(translationX: 0, y: 0)
                        icon?.transform = CGAffineTransform(translationX: 0, y: 0)
                        divider?.transform = CGAffineTransform(translationX: 0, y: 0)
                    })
                })
            })
        })
    }
}
