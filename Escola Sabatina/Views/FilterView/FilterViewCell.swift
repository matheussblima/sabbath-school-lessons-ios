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
        
        initialSetup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterViewCell {
    func initialSetup() {
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension FilterViewCell {
    func setTitleButton(_ title: String) {
        button.setTitle(title, for: .normal)
    }
    
    func selectedButton() {
        button.setTitleColor(.white, for: .normal)
        button.configuration = .filled()
        button.configuration?.background.backgroundColor = R.color.primaryColor()
        button.configuration?.cornerStyle = .capsule
    }
    
    func setUnSelectedButton() {
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
}
