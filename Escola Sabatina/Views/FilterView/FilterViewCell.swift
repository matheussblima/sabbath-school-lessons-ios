//
//  FilterViewCell.swift
//  Escola Sabatina
//
//  Created by Matheus Santana Barbosa Lima on 23/06/23.
//

import Foundation
import UIKit

protocol FilterViewCellDelegete: AnyObject {
    func didButtonTapped(cell: FilterViewCell) -> Void
}

class FilterViewCell: UICollectionViewCell {
    static let indentifier =  "idFilterViewCell"
    
    var button: UIButton = UIButton(type: .system)
    
    weak var delegate: FilterViewCellDelegete?
    
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
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
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
    
    func selectedButton() {
        button.setTitleColor(.white, for: .normal)
        button.configuration = .filled()
        button.configuration?.titleLineBreakMode = .byTruncatingTail
        button.configuration?.background.backgroundColor = R.color.primaryColor()
        button.configuration?.cornerStyle = .capsule
    }
    
    func setUnSelectedButton() {
        button.setTitleColor(.gray, for: .normal)
        button.configuration = .none
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    @objc private func buttonTapped() {
        delegate?.didButtonTapped(cell: self)
    }
}
