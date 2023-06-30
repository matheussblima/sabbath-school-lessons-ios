//
//  FilterViewCell.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 23/06/23.
//

import Foundation
import UIKit

class FilterViewCell: UICollectionViewCell {
    var button: UIButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterViewCell {
    func style() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
    }
    
    func layout() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension FilterViewCell {
    func setTitleButton(_ title: String) {
        button.setTitle(title, for: .normal)
    }
}
